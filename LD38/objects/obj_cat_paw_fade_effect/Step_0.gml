/// @description Fade

if (image_alpha > 0)
{
	image_alpha -= 0.1;
	
	var newFade = instance_create_layer(x, y, self.layer, obj_cat_paw_fade_effect);
	newFade._followingTaget = self;

	newFade.image_alpha = image_alpha - 0.1;
	newFade.image_index = image_index;
	newFade.sprite_index = sprite_index;
}
else
{
	instance_destroy();
}
