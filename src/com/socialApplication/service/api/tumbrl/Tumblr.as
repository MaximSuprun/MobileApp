package com.socialApplication.service.api.tumbrl
{
    import com.adobe.serialization.json.*;
    import com.pointroll.api.activities.*;
    import com.pointroll.api.events.social.*;
    import com.pointroll.api.logging.*;
    import com.pointroll.api.social.twitter.*;
    import com.pointroll.api.utils.net.*;
    import com.pointroll.api.utils.string.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import pointroll.*;

    public class Tumblr extends EventDispatcher
    {
        private var appID:String;
        private var sessionID:String;
        private var oauth:String;
        private var shortName:String;
        protected var oauthService:String = "http://dds.pointroll.com/api/data/18?_format=json&";
        protected var tumblrRequestURL:String = "http://dds.pointroll.com/api/data/18?_format=json&action=request&url=";
        private var oAuthURL:String;
        private var baseTumblrRequest:URLRequest;
        private var tumblrBlogInfo:URLRequest;
        private var tumblrAPIReq:URLRequest;
        private var tumblrParams:URLVariables;
        private var userShortName:String;
        private var _consumerKey:String;
        private var tumblrLoader:URLLoader;
        private var tumblrUserInfoLoader:URLLoader;
        private var tumblrSetupLoader:URLLoader;
        private var tumblrInfoLoader:URLLoader;
        private var tumblrXMLLoader:URLLoader;
        private var tumblrFollowerLoader:URLLoader;
        public var hostName:String;
        private var userVerified:Boolean = false;
        private var _customName:Boolean = false;
        private static const POST:String = "post";
        private static const GET_POSTS:String = "getposts";
        private static const GET_SESSION_ID:String = "getsession";
        private static const GET_FOLLOWERS:String = "getfollowers";
        private static const GET_CONSUMER_KEY:String = "getconsumerkey";
        private static const GET_BLOG_INFO:String = "getbloginfo";
        private static const USER_INFO:String = "userinfo";
        private static const VERIFY:String = "verify";

        public function Tumblr(param1:String = "", param2:String = "")
        {
            this.tumblrLoader = new URLLoader();
            this.tumblrUserInfoLoader = new URLLoader();
            this.tumblrSetupLoader = new URLLoader();
            this.tumblrInfoLoader = new URLLoader();
            this.tumblrXMLLoader = new URLLoader();
            this.tumblrFollowerLoader = new URLLoader();
            this.appID = param1;
            this.hostName = param2;
            this.tumblrRequestURL = returnHttpProtocol(this.tumblrRequestURL);
            this.baseTumblrRequest = new URLRequest(returnHttpProtocol(this.oauthService));
            this.tumblrLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrSetupLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrInfoLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrXMLLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrFollowerLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrUserInfoLoader.addEventListener(Event.COMPLETE, this.tumblrLoadHandler);
            this.tumblrUserInfoLoader.addEventListener(ErrorEvent.ERROR, this.tumblrErrorHandler);
            this.tumblrInfoLoader.addEventListener(ErrorEvent.ERROR, this.tumblrErrorHandler);
            this.tumblrXMLLoader.addEventListener(ErrorEvent.ERROR, this.tumblrErrorHandler);
            this.tumblrLoader.addEventListener(IOErrorEvent.IO_ERROR, this.tumblrErrorHandler);
            this.tumblrInfoLoader.addEventListener(IOErrorEvent.IO_ERROR, this.tumblrErrorHandler);
            this.tumblrXMLLoader.addEventListener(IOErrorEvent.IO_ERROR, this.tumblrErrorHandler);
            this.addEventListener(TumblrEvent.SESSION_ID_ACQUIRED, this.callOauthWindow);
            try
            {
                ExternalInterface.addCallback("tumblrLogginHandler", this.tumblrAuthorizationComplete);
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        protected function isCustomName() : Boolean
        {
            return this.hostName.indexOf("http") > -1 ? (true) : (false);
        }// end function

        public function get consumerKey() : String
        {
            if (!this._consumerKey)
            {
                throw new Error("PR:Tumblr - Please define the OAuth Consumer Key");
            }
            return this._consumerKey;
        }// end function

        public function set consumerKey(param1:String) : void
        {
            this._consumerKey = param1;
            return;
        }// end function

        public function init() : void
        {
            this._customName = this.isCustomName();
            this.shortName = this.getBlogName(this.hostName);
            Logger.log(" Initialize", 1, "PR:Tumblr");
            dispatchEvent(new TumblrEvent(TumblrEvent.INIT));
            return;
        }// end function

        public function getBlogInfo() : void
        {
            this.tumblrBlogInfo = new URLRequest(returnHttpProtocol("http://api.tumblr.com/v2/blog/" + this.shortName + "/info?"));
            this.tumblrParams = new URLVariables();
            this.tumblrParams.api_key = this.consumerKey;
            this.tumblrParams.m = GET_BLOG_INFO;
            this.tumblrBlogInfo.data = this.tumblrParams;
            this.tumblrInfoLoader.load(this.tumblrBlogInfo);
            return;
        }// end function

        public function getFollowers(param1:Number = 20) : void
        {
            this.tumblrAPIReq = new URLRequest();
            this.tumblrAPIReq.url = returnHttpProtocol("http://dds.pointroll.com/api/data/18?_format=xml&action=request&url=");
            this.tumblrAPIReq.url = this.tumblrAPIReq.url + (returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.userShortName + ".tumblr.com/followers/");
            this.tumblrAPIReq.url = this.tumblrAPIReq.url + ("?limit=" + param1);
            this.tumblrAPIReq.url = this.tumblrAPIReq.url + ("&oid=" + this.appID + "&sessionid=" + this.sessionID + "&method=GET&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = GET_FOLLOWERS;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrFollowerLoader.load(this.tumblrAPIReq);
            Logger.log(" GET Followers ", 2, "PR:Tumblr");
            return;
        }// end function

        public function getPosts(param1:String = "", param2:Number = 20, param3:String = "text", param4:String = "") : void
        {
            this.tumblrAPIReq = new URLRequest();
            this.tumblrAPIReq.url = returnHttpProtocol("http://cgizmo.pointroll.com/api/data/47?_format=xml&_cache=30m&url=");
            var _loc_5:* = returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.shortName + "/posts/";
            if (param1 != "")
            {
                _loc_5 = _loc_5 + (param1 + "?");
            }
            else
            {
                _loc_5 = _loc_5 + "?";
            }
            _loc_5 = _loc_5 + ("&limit=" + param2);
            _loc_5 = _loc_5 + ("&filter=" + param3);
            if (param4 != "")
            {
                _loc_5 = _loc_5 + ("&tag=" + param4);
            }
            _loc_5 = _loc_5 + ("&api_key=" + this.consumerKey + "&");
            this.tumblrAPIReq.url = this.tumblrAPIReq.url + escape(_loc_5);
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = GET_POSTS;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrXMLLoader.load(this.tumblrAPIReq);
            trackNonUIActivity(TumblrActivities.GET_POSTS);
            return;
        }// end function

        public function getAvatar(param1:String = "", param2:Number = 48) : String
        {
            return returnHttpProtocol("http://api.tumblr.com/v2/blog/" + this.getBlogName(param1) + "/avatar/" + param2);
        }// end function

        public function postText(param1:String, param2:String = "", param3:String = "") : void
        {
            this.tumblrAPIReq = new URLRequest(this.tumblrRequestURL + returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.userShortName + ".tumblr.com/post" + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=POST&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.$type = "text";
            this.tumblrParams.$slug = param1;
            if (param3 != "")
            {
                this.tumblrParams.$tag = param3;
            }
            this.tumblrParams.$title = param2;
            this.tumblrParams.$body = param1;
            this.tumblrParams.m = POST;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrLoader.load(this.tumblrAPIReq);
            Logger.log(" POST Text ", 2, "PR:Tumblr");
            return;
        }// end function

        public function postPhoto(param1:String, param2:String = "", param3:String = "", param4:String = "") : void
        {
            this.tumblrAPIReq = new URLRequest(this.tumblrRequestURL + returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.userShortName + ".tumblr.com/post" + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=POST&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.$type = "photo";
            this.tumblrParams.$source = param1;
            this.tumblrParams.$caption = param2;
            if (param4 != "")
            {
                this.tumblrParams.$tag = param4;
            }
            this.tumblrParams.$link = param3;
            this.tumblrParams.m = POST;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrLoader.load(this.tumblrAPIReq);
            Logger.log(" POST Photo ", 2, "PR:Tumblr");
            return;
        }// end function

        public function postAudio(param1:String, param2:String = "", param3:String = "") : void
        {
            this.tumblrAPIReq = new URLRequest(this.tumblrRequestURL + returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.userShortName + ".tumblr.com/post" + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=POST&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.$type = "audio";
            this.tumblrParams.$external_url = param1;
            this.tumblrParams.$caption = param2;
            if (param3 != "")
            {
                this.tumblrParams.$tag = param3;
            }
            this.tumblrParams.m = POST;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrLoader.load(this.tumblrAPIReq);
            Logger.log(" POST Audio ", 2, "PR:Tumblr");
            return;
        }// end function

        public function postVideo(param1:String, param2:String = "", param3:String = "") : void
        {
            this.tumblrAPIReq = new URLRequest(this.tumblrRequestURL + returnHttpProtocol("http://api.tumblr.com/v2/blog/") + this.userShortName + ".tumblr.com/post" + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=POST&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.$type = "video";
            this.tumblrParams.$embed = param1;
            this.tumblrParams.$caption = param2;
            if (param3 != "")
            {
                this.tumblrParams.$tag = param3;
            }
            this.tumblrParams.m = POST;
            this.tumblrAPIReq.data = this.tumblrParams;
            this.tumblrLoader.load(this.tumblrAPIReq);
            Logger.log(" POST Video ", 2, "PR:Tumblr");
            return;
        }// end function

        public function getUserInfo() : void
        {
            this.tumblrBlogInfo = new URLRequest(returnHttpProtocol("http://dds.pointroll.com/api/data/18?_format=xml&action=request&url=") + returnHttpProtocol("http://api.tumblr.com/v2/user/info") + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=GET&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = USER_INFO;
            this.tumblrBlogInfo.data = this.tumblrParams;
            this.tumblrUserInfoLoader.load(this.tumblrBlogInfo);
            return;
        }// end function

        private function verifyUserName() : void
        {
            this.tumblrBlogInfo = new URLRequest(this.tumblrRequestURL + returnHttpProtocol("http://api.tumblr.com/v2/user/info") + "&sessionid=" + this.sessionID + "&oid=" + this.appID + "&method=GET&");
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = VERIFY;
            this.tumblrBlogInfo.data = this.tumblrParams;
            this.tumblrLoader.load(this.tumblrBlogInfo);
            return;
        }// end function

        public function launchTumblrOauthWindow() : void
        {
            if (!this.sessionID)
            {
                this.getSessionID();
            }
            else
            {
                dispatchEvent(new Event(TumblrEvent.SESSION_ID_ACQUIRED));
            }
            return;
        }// end function

        private function callOauthWindow(event:Event) : void
        {
            var e:* = event;
            try
            {
                Logger.log(" Launch Login Window", 1, "PR:Tumblr");
                if (!this.userVerified)
                {
                    ExternalInterface.call("function (){var TumblrWindow=window.open(\'" + this.oAuthURL + "\',\'tumblrWindow\',\'width=820,height=425,left=0,top=0,toolbar=No,location=No,scrollbars=No,status=No,resizable=Yes,fullscreen=No\'); TumblrWindow.focus(); var timer = setInterval(function() { if(TumblrWindow.closed) {  clearInterval(timer);var objID = \'" + ExternalInterface.objectID + "\';var elem = ((navigator.userAgent.toLowerCase().indexOf(\'msie\') >= 0) ? \'OBJECT\' : \'EMBED\');var objRef = document.getElementById(objID).parentNode.getElementsByTagName(elem)[0];if (!objRef) objRef = document.getElementById(objID);if (!objRef) objRef = document.getElementsByName(objID)[0];objRef.tumblrLogginHandler(); }  }, 1000);}");
                }
                else
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.VERIFY_USER));
                }
            }
            catch (error:Error)
            {
                dispatchEvent(new TumblrEvent(TumblrEvent.VERIFY_FAILED));
            }
            return;
        }// end function

        public function getSessionID() : void
        {
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = GET_SESSION_ID;
            this.tumblrParams.oid = this.appID;
            this.baseTumblrRequest.data = this.tumblrParams;
            this.tumblrSetupLoader.load(this.baseTumblrRequest);
            return;
        }// end function

        private function getConsumerKey(event:Event) : void
        {
            this.tumblrParams = new URLVariables();
            this.tumblrParams.m = GET_CONSUMER_KEY;
            this.tumblrParams.oid = this.appID;
            this.tumblrParams.action = "data";
            this.baseTumblrRequest.data = this.tumblrParams;
            this.tumblrSetupLoader.load(this.baseTumblrRequest);
            return;
        }// end function

        private function tumblrAuthorizationComplete() : void
        {
            this.verifyUserName();
            return;
        }// end function

        private function tumblrLoadHandler(event:Event) : void
        {
            var _loc_5:Object = null;
            var _loc_2:* = TwitterLoader(event.target);
            var _loc_3:* = TwitterLoader(event.target).urlVariables.m;
            var _loc_4:* = new XML(_loc_2.data);
            Logger.log(" LOAD EVENT VARIABLE " + _loc_3, 4, "PR:Tumblr");
            try
            {
                _loc_5 = this.convertToNativeObject(event.target.data);
            }
            catch (e:Error)
            {
            }
            switch(_loc_3)
            {
                case GET_SESSION_ID:
                {
                    this.sessionID = _loc_5.sessionId;
                    if (isHttpSecure())
                    {
                        this.oAuthURL = replace(_loc_5.url, "http", "https");
                    }
                    else
                    {
                        this.oAuthURL = _loc_5.url;
                    }
                    dispatchEvent(new Event(TumblrEvent.SESSION_ID_ACQUIRED));
                    break;
                }
                case GET_CONSUMER_KEY:
                {
                    this.removeEventListener(TumblrEvent.GET_CONSUMER_KEY, this.getConsumerKey);
                    this.consumerKey = _loc_5.consumerKey;
                    break;
                }
                case GET_BLOG_INFO:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.BLOG_INFO, _loc_5.response.blog));
                    break;
                }
                case USER_INFO:
                {
                    if (!this.userShortName)
                    {
                        this.userShortName = _loc_4.blogs.name[0];
                    }
                    dispatchEvent(new TumblrEvent(TumblrEvent.USER_INFO, _loc_4));
                    break;
                }
                case GET_FOLLOWERS:
                {
                    if (_loc_4.*.length() > 1)
                    {
                        dispatchEvent(new TumblrEvent(TumblrEvent.GET_FOLLOWERS, _loc_4));
                    }
                    break;
                }
                case GET_POSTS:
                {
                    if (_loc_4.*.length() > 1)
                    {
                        dispatchEvent(new TumblrEvent(TumblrEvent.GET_POSTS, _loc_4));
                    }
                    else
                    {
                        dispatchEvent(new TumblrEvent(TumblrEvent.GET_POSTS_FAILED));
                    }
                    break;
                }
                case VERIFY:
                {
                    this.userShortName = _loc_5.response.user.name;
                    this.userVerified = true;
                    dispatchEvent(new TumblrEvent(TumblrEvent.VERIFY_USER, _loc_5.response.user));
                    break;
                }
                case POST:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.POST));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function convertToNativeObject(param1:String) : Object
        {
            var _loc_2:Object = null;
            if (param1.charAt(0) != "<")
            {
            }
            if (param1 == "")
            {
                var _loc_3:String = "";
                _loc_2["data"] = "";
                return _loc_3;
            }
            return JSON.decode(param1);
        }// end function

        private function tumblrErrorHandler(event:Event) : void
        {
            var _loc_2:* = URLLoader(event.target).urlVariables.m;
            trace(" : ERROR " + " ON " + event.type + " EVENT", 4, "PR:Tumblr");
            switch(_loc_2)
            {
                case VERIFY:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.VERIFY_FAILED));
                    break;
                }
                case POST:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.POST_FAILED));
                    break;
                }
                case GET_BLOG_INFO:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.BLOG_INFO_FAILED));
                    break;
                }
                case GET_POSTS:
                {
                    dispatchEvent(new TumblrEvent(TumblrEvent.GET_POSTS_FAILED));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getBlogName(param1:String) : String
        {
            return param1.indexOf("http") > -1 ? (strip(param1, "http://", "https://")) : (var _loc_2:* = param1 + ".tumblr.com", param1 = param1 + ".tumblr.com", _loc_2);
        }// end function

    }
}
