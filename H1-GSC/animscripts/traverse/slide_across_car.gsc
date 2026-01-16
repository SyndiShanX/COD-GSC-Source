/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\slide_across_car.gsc
*****************************************************/

main() {
  if(self.type == "dog")
    slide_across_car_dog();
  else
    slide_across_car_human();
}

#using_animtree("generic_human");

slide_across_car_human() {
  var_0 = [];
  var_0["traverseAnim"] = % slide_across_car;
  var_0["traverseToCoverAnim"] = % slide_across_car_2_cover;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 38.0;
  var_0["interruptDeathAnim"][0] = animscripts\utility::array( % slide_across_car_death);
  var_0["traverseSound"] = "npc_car_slide_hood";
  var_0["traverseToCoverSound"] = "npc_car_slide_cover";
  animscripts\traverse\shared::dotraverse(var_0);
}

#using_animtree("dog");

slide_across_car_dog() {
  self endon("killanimscript");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim( % animscript_root, 0.1);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_up_40"], 1, 0.1, 1);
  animscripts\shared::donotetracks("traverse");
  thread common_scripts\utility::play_sound_in_space("anml_dog_bark", self gettagorigin("tag_eye"));
  self clearanim( % animscript_root, 0);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_down_40"], 1, 0, 1);
  animscripts\shared::donotetracks("traverse");
  self traversemode("gravity");
}