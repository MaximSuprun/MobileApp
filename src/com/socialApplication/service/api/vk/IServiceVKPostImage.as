package com.socialApplication.service.api.vk
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServiceVKPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}