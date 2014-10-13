package com.socialApplication.service.api.facebook
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServiceFacebookPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}