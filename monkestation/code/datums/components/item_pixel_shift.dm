/datum/component/item_pixel_shift
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/shifting_items = TRUE
	var/maximum_item_offset = 16
	var/grabbed_item

/datum/component/item_pixel_shift/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/item_pixel_shift/RegisterWithParent()
	RegisterSignal(parent, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_DOWN, PROC_REF(item_pixel_shift_down))
	RegisterSignal(parent, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(pre_move_check))
	RegisterSignal(parent, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_UP, PROC_REF(item_pixel_shift_up))

/datum/component/item_pixel_shift/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_DOWN)
	UnregisterSignal(parent, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_UP)
	UnregisterSignal(parent, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE)

/datum/component/item_pixel_shift/proc/item_pixel_shift_down()
	SIGNAL_HANDLER
	shifting_items = TRUE
	return COMSIG_KB_ACTIVATED

/datum/component/item_pixel_shift/proc/item_pixel_shift_up()
	SIGNAL_HANDLER

	qdel(src)

/datum/component/item_pixel_shift/proc/pre_move_check(mob/source, new_loc, direct)
	SIGNAL_HANDLER
	if(shifting_items && source.pulling)
		shift_item(source, direct)
		return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE
	else
		return

/datum/component/item_pixel_shift/proc/shift_item(mob/source, direct)
	var/atom/pulled_atom = source.pulling
	grabbed_item = pulled_atom
	if(!isitem(pulled_atom))
		return
	var/obj/item/pulled_item = pulled_atom
	switch(direct)
		if(NORTH)
			if(pulled_item.pixel_y <= maximum_item_offset + pulled_item.base_pixel_y)
				pulled_item.pixel_y++
		if(EAST)
			if(pulled_item.pixel_x <= maximum_item_offset + pulled_item.base_pixel_x)
				pulled_item.pixel_x++
		if(SOUTH)
			if(pulled_item.pixel_y >= -maximum_item_offset + pulled_item.base_pixel_y)
				pulled_item.pixel_y--
		if(WEST)
			if(pulled_item.pixel_x >= -maximum_item_offset + pulled_item.base_pixel_x)
				pulled_item.pixel_x--




