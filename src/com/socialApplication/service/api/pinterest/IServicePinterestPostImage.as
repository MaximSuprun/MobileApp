package com.socialApplication.service.api.pinterest
{
	import com.socialApplication.model.vo.VOImageInfo;

	public interface IServicePinterestPostImage
	{
		function postImage(pImageInfo:VOImageInfo):void;
	}
}