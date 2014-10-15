package com.socialApplication.service.api.tumbrl
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServiceTumblrPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}