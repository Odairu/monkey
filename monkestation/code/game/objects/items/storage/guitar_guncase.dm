/obj/item/storage/toolbox/guncase/guitar
	name = "guitar gun case"
	desc = "A weapon's case, this one must be used by quite the rockstar"
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "infiltrator_case"

/obj/item/storage/toolbox/guncase/guitar/syndicate
	name = "guitar gun case"
	desc = "A weapon's case, this one must be used by quite the rockstar"
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "infiltrator_case"

/obj/item/storage/toolbox/guncase/guitar/syndicate/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/obj/item/gun/stored_gun = locate(/obj/item/gun) in src
	if(stored_gun)
		stored_gun.afterattack(target, user, proximity_flag, click_parameters)
	if(istype(stored_gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/ballistic_gun = stored_gun
		if(ballistic_gun.magazine.stored_ammo.len == 0 && (!ballistic_gun.internal_magazine))
			var/obj/item/ammo_box/magazine/mag = locate(ballistic_gun.accepted_magazine_type) in contents
			if(mag && mag.stored_ammo.len)
				ballistic_gun.eject_magazine(user, FALSE, null)
				ballistic_gun.insert_magazine(user, mag)
