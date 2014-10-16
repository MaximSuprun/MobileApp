/*

Библиотека для работы с API Мой Мир@Mail.Ru

http://flapps.ru/forum/ - форум о создании флеш приложений с использованием API различных социальных сетей

*/
package com.socialApplication.service.api.mailRu.my{
	public class MyApiNode {
		public var vid:String;
		public var app_id:Number;
		public var private_key:String;
		public var session_key:String;
		public var format:String;
		public var server_url:String;

		public function MyApiNode(vid: String,
								  app_id: Number,
								  private_key: String, 
								  session_key: String,
								  format: String = 'JSON',
								  server_url: String = 'http://www.appsmail.ru/platform/api?') {
			this.vid=vid;
			this.app_id=app_id;
			this.private_key=private_key;
			this.session_key=session_key;
			this.format=format;
			this.server_url=server_url;
		}

		/* Friends */
		public function friendsGet(ext: Number = -1):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'friends.get',
									   private_key,
									   session_key,
									   format,
									   server_url);
			if (ext!=-1) {
				api.addParameter('ext', ext.toString());
			}
			return api.getQuery();
		}

		public function friendsGetAppUsers(ext: Number = -1):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'friends.getAppUsers',
									   private_key,
									   session_key,
									   format,
									   server_url);
			if (ext!=-1) {
				api.addParameter('ext', ext.toString());
			}
			return api.getQuery();
		}

		/* Users */
		public function isAppUser(uid: Number = -1):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'users.isAppUser',
									   private_key,
									   session_key,
									   format,
									   server_url);
			if (uid!=-1) {
				api.addParameter('uid', uid.toString());
			}
			return api.getQuery();
		}


		public function usersGetInfo(uids: Array):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'users.getInfo',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('uids', uids.join(','));
			return api.getQuery();
		}

		public function usersHasAppPermission(ext_perm: String):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'users.hasAppPermission',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('ext_perm', ext_perm);
			return api.getQuery();
		}
		
		/* Payments */
		public function paymentsOpenDialog(window_id: String, service_id: Number, service_name: String, sms_price: Number = -1, other_price: Number = -1):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'payments.openDialog',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('window_id', window_id);
			api.addParameter('service_id', service_id.toString());
			api.addParameter('service_name', service_name);
			if (sms_price!=-1) {
				api.addParameter('sms_price', sms_price.toString());
			}
			if (other_price!=-1) {
				api.addParameter('other_price', other_price.toString());
			}
			return api.getQuery();
		}		
		
		/* Stream */
		public function streamPublish(title: String, text: String, img: String = "-1"):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'stream.post',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('title', title);
			api.addParameter('text', text);
			if (img!="-1") {
				api.addParameter('img_url', img.toString());
			}
			return api.getQuery();
		}				
		
		/* Photos */
		public function photosGetAlbums(aids: String = null):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'photos.getAlbums',
									   private_key,
									   session_key,
									   format,
									   server_url);
			if (aids) {
				api.addParameter('aids', aids);
			}
			return api.getQuery();
		}				

		public function photosGet(aid: String = null, pids: String = null):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'photos.get',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('aid', aid);
			if (pids) {
				api.addParameter('pids', pids);
			}
			return api.getQuery();
		}		
		public function photosUpload(aid: String = null, img_url: String = null,name_photo: String = null,description: String = null,tags: String = null):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'photos.upload',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('aid', aid);
			if (img_url) {
				api.addParameter('img_url', img_url);
			}
			if (name_photo) {
				api.addParameter('name_photo', name_photo);
			}
			if (description) {
				api.addParameter('description', description);
			}
			if (tags) {
				api.addParameter('tags', tags);
			}
			return api.getQuery();
		}		
		
		
		/* Audios */
		public function audiosGet(mids: String = null):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'audios.get',
									   private_key,
									   session_key,
									   format,
									   server_url);
			if (mids) {
				api.addParameter('mids', mids);
			}
			return api.getQuery();
		}						
		
		public function audiosLinkAudio(mid: String):String {
			var api: MyApi = new MyApi(vid,
									   app_id,
									   'audios.linkAudio',
									   private_key,
									   session_key,
									   format,
									   server_url);
			api.addParameter('mid', mid.toString());
			return api.getQuery();
		}				
		
		
	}
}