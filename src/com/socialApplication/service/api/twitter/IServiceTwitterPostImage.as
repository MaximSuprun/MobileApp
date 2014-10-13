package com.socialApplication.service.api.twitter
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServiceTwitterPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}