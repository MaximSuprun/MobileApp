package com.socialApplication.service.api.mailRu
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServiceMailPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}