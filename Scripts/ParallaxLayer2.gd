extends ParallaxLayer


func _process(delta) -> void:
	self.motion_offset.x += -1
	self.motion_offset.y += 1
