package com.razzmatazz.feathers.layout {
	
	import feathers.layout.IVirtualLayout;
	import feathers.layout.LayoutBoundsResult;
	import feathers.layout.ViewPortBounds;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * @inheritDoc
	 */
	[Event(name="change",type="starling.events.Event")]

	/**
	 * Positions items as tiles (equal width and height) from left to right
	 * in multiple rows. Constrained to the suggested width, the tiled rows
	 * layout will change in height as the number of items increases or
	 * decreases
	 */
	public class FlowLayout extends EventDispatcher implements IVirtualLayout {

		/**
		 * Constructor.
		 */
		public function FlowLayout()
		{
		}

		/**
		 * @private
		 */
		private var _gapHorizontal:Number = 0;

		/**
		 * The space, in pixels, between tiles.
		 */
		public function get gapHorizontal():Number
		{
			return this._gapHorizontal;
		}

		/**
		 * @private
		 */
		public function set gapHorizontal(value:Number):void
		{
			if(this._gapHorizontal == value)
			{
				return;
			}
			this._gapHorizontal = value;
			this.dispatchEventWith(Event.CHANGE);
		}
		
		
		
		
		
		/**
		 * @private
		 */
		private var _gapVertical:Number = 0;
		
		/**
		 * The space, in pixels, between tiles.
		 */
		public function get gapVertical():Number
		{
			return this._gapVertical;
		}
		
		/**
		 * @private
		 */
		public function set gapVertical(value:Number):void
		{
			if(this._gapVertical == value)
			{
				return;
			}
			this._gapVertical = value;
			this.dispatchEventWith(Event.CHANGE);
		}
		
		
		
		
		

		/**
		 * @private
		 */
		protected var _paddingTop:Number = 0;

		/**
		 * The space, in pixels, above of items.
		 */
		public function get paddingTop():Number
		{
			return this._paddingTop;
		}

		/**
		 * @private
		 */
		public function set paddingTop(value:Number):void
		{
			if(this._paddingTop == value)
			{
				return;
			}
			this._paddingTop = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		/**
		 * @private
		 */
		protected var _paddingRight:Number = 0;

		/**
		 * The space, in pixels, to the right of the items.
		 */
		public function get paddingRight():Number
		{
			return this._paddingRight;
		}

		/**
		 * @private
		 */
		public function set paddingRight(value:Number):void
		{
			if(this._paddingRight == value)
			{
				return;
			}
			this._paddingRight = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		/**
		 * @private
		 */
		protected var _paddingBottom:Number = 0;

		/**
		 * The space, in pixels, below the items.
		 */
		public function get paddingBottom():Number
		{
			return this._paddingBottom;
		}

		/**
		 * @private
		 */
		public function set paddingBottom(value:Number):void
		{
			if(this._paddingBottom == value)
			{
				return;
			}
			this._paddingBottom = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		/**
		 * @private
		 */
		protected var _paddingLeft:Number = 0;

		/**
		 * The space, in pixels, to the left of the items.
		 */
		public function get paddingLeft():Number
		{
			return this._paddingLeft;
		}

		/**
		 * @private
		 */
		public function set paddingLeft(value:Number):void
		{
			if(this._paddingLeft == value)
			{
				return;
			}
			this._paddingLeft = value;
			this.dispatchEventWith(Event.CHANGE);
		}


		/**
		 * @private
		 */
		private var _useVirtualLayout:Boolean = true;

		/**
		 * @inheritDoc
		 */
		public function get useVirtualLayout():Boolean
		{
			return this._useVirtualLayout;
		}

		/**
		 * @private
		 */
		public function set useVirtualLayout(value:Boolean):void
		{
			if(this._useVirtualLayout == value)
			{
				return;
			}
			this._useVirtualLayout = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		/**
		 * @private
		 */
		private var _typicalItemWidth:Number = 0;

		/**
		 * @inheritDoc
		 */
		public function get typicalItemWidth():Number
		{
			return this._typicalItemWidth;
		}

		/**
		 * @private
		 */
		public function set typicalItemWidth(value:Number):void
		{
			if(this._typicalItemWidth == value)
			{
				return;
			}
			this._typicalItemWidth = value;
		}

		/**
		 * @private
		 */
		private var _typicalItemHeight:Number = 0;

		/**
		 * @inheritDoc
		 */
		public function get typicalItemHeight():Number
		{
			return this._typicalItemHeight;
		}

		/**
		 * @private
		 */
		public function set typicalItemHeight(value:Number):void
		{
			if(this._typicalItemHeight == value)
			{
				return;
			}
			this._typicalItemHeight = value;
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function layout(items:Vector.<DisplayObject>, viewPortBounds:ViewPortBounds = null, result:LayoutBoundsResult = null):LayoutBoundsResult
		{
			const boundsX:Number = viewPortBounds ? viewPortBounds.x : 0;
			const boundsY:Number = viewPortBounds ? viewPortBounds.y : 0;
			const minWidth:Number = viewPortBounds ? viewPortBounds.minWidth : 0;
			const minHeight:Number = viewPortBounds ? viewPortBounds.minHeight : 0;
			const maxWidth:Number = viewPortBounds ? viewPortBounds.maxWidth : Number.POSITIVE_INFINITY;
			const maxHeight:Number = viewPortBounds ? viewPortBounds.maxHeight : Number.POSITIVE_INFINITY;
			const explicitWidth:Number = viewPortBounds ? viewPortBounds.explicitWidth : NaN;
			const explicitHeight:Number = viewPortBounds ? viewPortBounds.explicitHeight : NaN;
			
			const itemCount:int = items.length;
			
			var availableWidth:Number = NaN;
			var availableHeight:Number = NaN;

			var horizontalTileCount:int = Math.max(1, itemCount);
			if(!isNaN(explicitWidth))
			{
				availableWidth = explicitWidth;
			}
			else if(!isNaN(maxWidth))
			{
				availableWidth = maxWidth;
			}
			var verticalTileCount:int = 1;
			if(!isNaN(explicitHeight))
			{
				availableHeight = explicitHeight;
			}
			else if(!isNaN(maxHeight))
			{
				availableHeight = maxHeight;
			}


			const startX:Number = boundsX + this._paddingLeft;
			const startY:Number = boundsY + this._paddingTop;

			var positionX:Number = startX;
			var positionY:Number = startY;
			
			var itemWidth:Number = 0;
			var itemHeight:Number = 0;
			
			var i:int=0;
			var item:DisplayObject;
			
			var pCurrentLineIndex:Number = 0;
			
			for( ; i<itemCount; ++i){
				item = items[i];
				itemWidth = item.width;
				itemHeight = item.height;
				
				//does the item fit on this line, or should we move to the next line?
				if(positionX+itemWidth > availableWidth-_paddingRight) {
					positionX = startX;
					++pCurrentLineIndex;
				}
				positionY = startY + pCurrentLineIndex * (itemHeight + this.gapVertical); 
				
				//position the element
				item.x = positionX;
				item.y = positionY;				
				positionX += item.width + this._gapHorizontal; 
			}
				
			if(!result)
			{
				result = new LayoutBoundsResult();
			}
			result.contentWidth = availableWidth;
			result.contentHeight = positionY+itemHeight;
			result.viewPortWidth = availableWidth-_paddingRight;
			result.viewPortHeight = availableHeight;

			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function measureViewPort(itemCount:int, viewPortBounds:ViewPortBounds = null, result:Point = null):Point
		{
			if(!result)
			{
				result = new Point();
			}
			const explicitWidth:Number = viewPortBounds ? viewPortBounds.explicitWidth : NaN;
			const explicitHeight:Number = viewPortBounds ? viewPortBounds.explicitHeight : NaN;
			const needsWidth:Boolean = isNaN(explicitWidth);
			const needsHeight:Boolean = isNaN(explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				result.x = explicitWidth;
				result.y = explicitHeight;
				return result;
			}

			const boundsX:Number = viewPortBounds ? viewPortBounds.x : 0;
			const boundsY:Number = viewPortBounds ? viewPortBounds.y : 0;
			const minWidth:Number = viewPortBounds ? viewPortBounds.minWidth : 0;
			const minHeight:Number = viewPortBounds ? viewPortBounds.minHeight : 0;
			const maxWidth:Number = viewPortBounds ? viewPortBounds.maxWidth : Number.POSITIVE_INFINITY;
			const maxHeight:Number = viewPortBounds ? viewPortBounds.maxHeight : Number.POSITIVE_INFINITY;

			const tileWidth:Number = this._typicalItemWidth;
			const tileHeight:Number = this._typicalItemHeight;

			var availableWidth:Number = NaN;
			var availableHeight:Number = NaN;

			var horizontalTileCount:int = Math.max(1, itemCount);
			if(!isNaN(explicitWidth))
			{
				availableWidth = explicitWidth;
				horizontalTileCount = Math.max(1, (explicitWidth - this._paddingLeft - this._paddingRight + this._gapHorizontal) / (tileWidth + this._gapHorizontal));
			}
			else if(!isNaN(maxWidth))
			{
				availableWidth = maxWidth;
				horizontalTileCount = Math.max(1, (maxWidth - this._paddingLeft - this._paddingRight + this._gapHorizontal) / (tileWidth + this._gapHorizontal));
			}
			var verticalTileCount:int = 1;
			if(!isNaN(explicitHeight))
			{
				availableHeight = explicitHeight;
				verticalTileCount = Math.max(1, (explicitHeight - this._paddingTop - this._paddingBottom + this._gapHorizontal) / (tileHeight + this._gapHorizontal));
			}
			else if(!isNaN(maxHeight))
			{
				availableHeight = maxHeight;
				verticalTileCount = Math.max(1, (maxHeight - this._paddingTop - this._paddingBottom + this._gapHorizontal) / (tileHeight + this._gapHorizontal));
			}

			const totalPageWidth:Number = horizontalTileCount * (tileWidth + this._gapHorizontal) - this._gapHorizontal + this._paddingLeft + this._paddingRight;
			const totalPageHeight:Number = verticalTileCount * (tileHeight + this._gapHorizontal) - this._gapHorizontal + this._paddingTop + this._paddingBottom;
			const availablePageWidth:Number = isNaN(availableWidth) ? totalPageWidth : availableWidth;
			const availablePageHeight:Number = isNaN(availableHeight) ? totalPageHeight : availableHeight;

			const startX:Number = boundsX + this._paddingLeft;
			const startY:Number = boundsY + this._paddingTop;

			const perPage:int = horizontalTileCount * verticalTileCount;
			var pageIndex:int = 0;
			var nextPageStartIndex:int = perPage;
			var pageStartX:Number = startX;
			var positionX:Number = startX;
			var positionY:Number = startY;
			for(var i:int = 0; i < itemCount; i++)
			{
				if(i != 0 && i % horizontalTileCount == 0)
				{
					positionX = pageStartX;
					positionY += tileHeight + this._gapHorizontal;
				}
				if(i == nextPageStartIndex)
				{
					pageIndex++;
					nextPageStartIndex += perPage;

					/*
					//we can use availableWidth and availableHeight here without
					//checking if they're NaN because we will never reach a
					//new page without them already being calculated.
					if(this._paging == PAGING_HORIZONTAL)
					{
						positionX = pageStartX = startX + availableWidth * pageIndex;
						positionY = startY;
					}
					else if(this._paging == PAGING_VERTICAL)
					{
						positionY = startY + availableHeight * pageIndex;
					}
					*/
				}
			}

			var totalWidth:Number = totalPageWidth;
			/*
			if(!isNaN(availableWidth) && this._paging == PAGING_HORIZONTAL)
			{
				totalWidth = Math.ceil(itemCount / perPage) * availableWidth;
			}
			*/
			
			var totalHeight:Number = positionY + tileHeight + this._paddingBottom;
			/*
			if(!isNaN(availableHeight))
			{
				if(this._paging == PAGING_HORIZONTAL)
				{
					totalHeight = availableHeight;
				}
				else if(this._paging == PAGING_VERTICAL)
				{
					totalHeight = Math.ceil(itemCount / perPage) * availableHeight;
				}
			}
			*/

			result.x = needsWidth ? Math.max(minWidth, totalWidth) : explicitWidth;
			result.y = needsHeight ? Math.max(minHeight, totalHeight) : explicitHeight;
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function getVisibleIndicesAtScrollPosition(scrollX:Number, scrollY:Number, width:Number, height:Number, itemCount:int, result:Vector.<int> = null):Vector.<int>
		{
			if(!result)
			{
				result = new <int>[];
			}
			result.length = 0;

			/*
			const tileWidth:Number = this._useSquareTiles ? Math.max(0, this._typicalItemWidth, this._typicalItemHeight) : this._typicalItemWidth;
			const tileHeight:Number = this._useSquareTiles ? tileWidth : this._typicalItemHeight;
			const horizontalTileCount:int = Math.max(1, (width - this._paddingLeft - this._paddingRight + this._gap) / (tileWidth + this._gap));
			if(this._paging != PAGING_NONE)
			{
				var verticalTileCount:int = Math.max(1, (height - this._paddingTop - this._paddingBottom + this._gap) / (tileHeight + this._gap));
				const perPage:Number = horizontalTileCount * verticalTileCount;
				if(this._paging == PAGING_HORIZONTAL)
				{
					var startPageIndex:int = Math.round(scrollX / width);
					var minimum:int = startPageIndex * perPage;
					var totalRowWidth:Number = horizontalTileCount * (tileWidth + this._gap) - this._gap;
					var leftSideOffset:Number = 0;
					var rightSideOffset:Number = 0;
					if(totalRowWidth < width)
					{
						if(this._horizontalAlign == HORIZONTAL_ALIGN_RIGHT)
						{
							leftSideOffset = width - this._paddingLeft - this._paddingRight - totalRowWidth;
							rightSideOffset = 0;
						}
						else if(this._horizontalAlign == HORIZONTAL_ALIGN_CENTER)
						{
							leftSideOffset = rightSideOffset = (width - this._paddingLeft - this._paddingRight - totalRowWidth) / 2;
						}
						else if(this._horizontalAlign == HORIZONTAL_ALIGN_LEFT)
						{
							leftSideOffset = 0;
							rightSideOffset = width - this._paddingLeft - this._paddingRight - totalRowWidth;
						}
					}
					var columnOffset:int = 0;
					var pageStartPosition:Number = startPageIndex * width;
					var partialPageSize:Number = scrollX - pageStartPosition;
					if(partialPageSize < 0)
					{
						partialPageSize = Math.max(0, -partialPageSize - this._paddingRight - rightSideOffset);
						columnOffset = -Math.floor(partialPageSize / (tileWidth + this._gap)) - 1;
						minimum += -perPage + horizontalTileCount + columnOffset;
					}
					else if(partialPageSize > 0)
					{
						partialPageSize = Math.max(0, partialPageSize - this._paddingLeft - leftSideOffset);
						columnOffset = Math.floor(partialPageSize / (tileWidth + this._gap));
						minimum += columnOffset;
					}
					if(minimum < 0)
					{
						minimum = 0;
						columnOffset = 0;
					}
					var rowIndex:int = 0;
					var columnIndex:int = (horizontalTileCount + columnOffset) % horizontalTileCount;
					var maxColumnIndex:int = columnIndex + horizontalTileCount + 2;
					var pageStart:int = int(minimum / perPage) * perPage;
					var i:int = minimum;
					do
					{
						result.push(i);
						rowIndex++;
						if(rowIndex == verticalTileCount)
						{
							rowIndex = 0;
							columnIndex++;
							if(columnIndex == horizontalTileCount)
							{
								columnIndex = 0;
								pageStart += perPage;
								maxColumnIndex -= horizontalTileCount;
							}
							i = pageStart + columnIndex - horizontalTileCount;
						}
						i += horizontalTileCount;
					}
					while(columnIndex != maxColumnIndex)
				}
				else
				{
					startPageIndex = Math.round(scrollY / height);
					minimum = startPageIndex * perPage;
					if(minimum > 0)
					{
						pageStartPosition = startPageIndex * height;
						partialPageSize = scrollY - pageStartPosition;
						if(partialPageSize < 0)
						{
							minimum -= horizontalTileCount * Math.ceil((-partialPageSize - this._paddingBottom) / (tileHeight + this._gap));
						}
						else if(partialPageSize > 0)
						{
							minimum += horizontalTileCount * Math.floor((partialPageSize - this._paddingTop) / (tileHeight + this._gap));
						}
					}
					var maximum:int = minimum + perPage + 2 * horizontalTileCount - 1;
					for(i = minimum; i <= maximum; i++)
					{
						result.push(i);
					}
				}
			}
			else
			{
				var rowIndexOffset:int = 0;
				const totalRowHeight:Number = Math.ceil(itemCount / horizontalTileCount) * (tileHeight + this._gap) - this._gap;
				if(totalRowHeight < height)
				{
					if(this._verticalAlign == VERTICAL_ALIGN_BOTTOM)
					{
						rowIndexOffset = Math.ceil((height - totalRowHeight) / (tileHeight + this._gap));
					}
					else if(this._verticalAlign == VERTICAL_ALIGN_MIDDLE)
					{
						rowIndexOffset = Math.ceil((height - totalRowHeight) / (tileHeight + this._gap) / 2);
					}
				}
				rowIndex = -rowIndexOffset + Math.floor((scrollY - this._paddingTop + this._gap) / (tileHeight + this._gap));
				verticalTileCount = Math.ceil((height - this._paddingTop + this._gap) / (tileHeight + this._gap)) + 1;
				minimum = rowIndex * horizontalTileCount;
				maximum = minimum + horizontalTileCount * verticalTileCount;
				for(i = minimum; i <= maximum; i++)
				{
					result.push(i);
				}
			}
			*/
			
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function getScrollPositionForIndex(index:int, items:Vector.<DisplayObject>, x:Number, y:Number, width:Number, height:Number, result:Point = null):Point
		{
			if(!result)
			{
				result = new Point();
			}

			/*
			const itemCount:int = items.length;
			var tileWidth:Number = this._useSquareTiles ? Math.max(0, this._typicalItemWidth, this._typicalItemHeight) : this._typicalItemWidth;
			var tileHeight:Number = this._useSquareTiles ? tileWidth : this._typicalItemHeight;
			//a virtual layout assumes that all items are the same size as
			//the typical item, so we don't need to measure every item in
			//that case
			if(!this._useVirtualLayout)
			{
				for(var i:int = 0; i < itemCount; i++)
				{
					var item:DisplayObject = items[i];
					if(!item)
					{
						continue;
					}
					tileWidth = this._useSquareTiles ? Math.max(tileWidth, item.width, item.height) : Math.max(tileWidth, item.width);
					tileHeight = this._useSquareTiles ? Math.max(tileWidth, tileHeight) : Math.max(tileHeight, item.height);
				}
			}
			const horizontalTileCount:int = Math.max(1, (width - this._paddingLeft - this._paddingRight + this._gap) / (tileWidth + this._gap));
			if(this._paging != PAGING_NONE)
			{
				const verticalTileCount:int = Math.max(1, (height - this._paddingTop - this._paddingBottom + this._gap) / (tileHeight + this._gap));
				const perPage:Number = horizontalTileCount * verticalTileCount;
				const pageIndex:int = index / perPage;
				if(this._paging == PAGING_HORIZONTAL)
				{
					result.x = pageIndex * width;
					result.y = 0;
				}
				else
				{
					result.x = 0;
					result.y = pageIndex * height;
				}
			}
			else
			{
				result.x = 0;
				result.y = this._paddingTop + ((tileHeight + this._gap) * index / horizontalTileCount) + (height - tileHeight) / 2;
			}
			*/
			
			return result;
		}

		/**
		 * @private
		 */
		/*
		protected function applyHorizontalAlign(items:Vector.<DisplayObject>, startIndex:int, endIndex:int, totalItemWidth:Number, availableWidth:Number):void
		{
			if(totalItemWidth >= availableWidth)
			{
				return;
			}
			var horizontalAlignOffsetX:Number = 0;
			if(this._horizontalAlign == HORIZONTAL_ALIGN_RIGHT)
			{
				horizontalAlignOffsetX = availableWidth - totalItemWidth;
			}
			else if(this._horizontalAlign != HORIZONTAL_ALIGN_LEFT)
			{
				//we're going to default to center if we encounter an
				//unknown value
				horizontalAlignOffsetX = (availableWidth - totalItemWidth) / 2;
			}
			if(horizontalAlignOffsetX != 0)
			{
				for(var i:int = startIndex; i <= endIndex; i++)
				{
					var item:DisplayObject = items[i];
					item.x += horizontalAlignOffsetX;
				}
			}
		}
		*/

		/**
		 * @private
		 */
		
		/*
		protected function applyVerticalAlign(items:Vector.<DisplayObject>, startIndex:int, endIndex:int, totalItemHeight:Number, availableHeight:Number):void
		{
			if(totalItemHeight >= availableHeight)
			{
				return;
			}
			var verticalAlignOffsetY:Number = 0;
			if(this._verticalAlign == VERTICAL_ALIGN_BOTTOM)
			{
				verticalAlignOffsetY = availableHeight - totalItemHeight;
			}
			else if(this._verticalAlign == VERTICAL_ALIGN_MIDDLE)
			{
				verticalAlignOffsetY = (availableHeight - totalItemHeight) / 2;
			}
			if(verticalAlignOffsetY != 0)
			{
				for(var i:int = startIndex; i <= endIndex; i++)
				{
					var item:DisplayObject = items[i];
					item.y += verticalAlignOffsetY;
				}
			}
		}
		*/
	}
}
