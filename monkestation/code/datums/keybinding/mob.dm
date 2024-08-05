/datum/keybinding/mob/item_pixel_shift
	hotkey_keys = list("V")
	name = "item_pixel_shift"
	full_name = "Item Pixel Shift"
	description = "Shift a pulled item's offset"
	category = CATEGORY_MISC
	keybind_signal = COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_DOWN

/datum/keybinding/mob/item_pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/item_pixel_shift)

/datum/keybinding/mob/item_pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_UP)
