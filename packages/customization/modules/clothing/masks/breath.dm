/obj/item/clothing/mask/breath/vox
	desc = "A close-fitting mask that can be connected to an air supply. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	name = "vox breath mask"
	actions_types = list()
	flags_cover = NONE

/obj/item/clothing/mask/balaclavaadjust
	name = "adjustable balaclava"
	desc = "Wider eyed and made of an elastic based material, this one seems like it can contort more."
	icon = 'packages/clothing/assets/obj/masks.dmi'
	worn_icon = 'packages/clothing/assets/mob/mask.dmi'
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	w_class = WEIGHT_CLASS_SMALL
	var/open = 0 //0 = full, 1 = head only, 2 = face only

/obj/item/clothing/mask/balaclavaadjust/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated())
		switch(open)
			if (0)
				flags_inv = HIDEHAIR
				icon_state = initial(icon_state) + "_open"
				to_chat(user, "You put the balaclava away, revealing your face.")
				open = 1
			if (1)
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
				icon_state = initial(icon_state) + "_mouth"
				to_chat(user, "You adjust the balaclava up to cover your mouth.")
				open = 2
			else
				flags_inv = HIDEFACE|HIDEHAIR
				icon_state = initial(icon_state)
				to_chat(user, "You pull the balaclava up to cover your whole head.")
				open = 0
		user.update_body_parts()
		user.update_inv_ears(0)
		user.update_worn_mask() //Updates mob icons

/obj/item/clothing/mask/balaclavaadjust/attack_self(mob/user)
	adjust_mask(user)

/obj/item/clothing/mask/balaclavaadjust/verb/toggle()
		set category = "Object"
		set name = "Adjust Balaclava"
		set src in usr
		adjust_mask(usr)


/obj/item/clothing/mask/balaclava/threehole
	name = "three hole balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'packages/clothing/assets/obj/masks.dmi'
	worn_icon = 'packages/clothing/assets/mob/mask.dmi'
	icon_state = "balaclavam"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEHAIR

/obj/item/clothing/mask/balaclava/threehole/green
	name = "three hole green balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'packages/clothing/assets/obj/masks.dmi'
	worn_icon = 'packages/clothing/assets/mob/mask.dmi'
	icon_state = "swatclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/muzzle/ball
	name = "ballgag"
	desc = "I'm pretty fuckin far from okay."
	icon = 'packages/clothing/assets/obj/masks.dmi'
	worn_icon = 'packages/clothing/assets/mob/mask.dmi'
	icon_state = "ballgag"

/obj/item/clothing/mask/muzzle/ring
	name = "ring gag"
	desc = "A mouth wrap seemingly designed to hold the mouth open."
	icon = 'packages/clothing/assets/obj/masks.dmi'
	worn_icon = 'packages/clothing/assets/mob/mask.dmi'
	icon_state = "ringgag"

/obj/item/clothing/mask/surgical/greyscale
	icon = 'packages/greyscale/assets/masks.dmi'
	worn_icon = 'packages/greyscale/assets/masks.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#AAE4DB"
	greyscale_config = /datum/greyscale_config/sterile_mask
	greyscale_config_worn = /datum/greyscale_config/sterile_mask/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sterile_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/sterile_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/sterile_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/sterile_mask/worn/teshari
