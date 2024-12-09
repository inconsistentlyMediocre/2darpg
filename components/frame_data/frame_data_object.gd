class_name FrameDataObject
extends Resource


enum FrameType {
	SINGLE,
	MULTI,
	EMPTY,
}

@export var type: FrameType
@export var hitboxes: Array[int]
