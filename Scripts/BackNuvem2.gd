extends ParallaxLayer


func _process(delta) -> void:
	self.motion_offset.x -= 0.04
	self.motion_offset.y -= 0.04
