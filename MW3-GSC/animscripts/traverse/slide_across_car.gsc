/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\slide_across_car.gsc
*****************************************************/

main() {
  if(self.type == "dog") {
    _id_4005();
  } else {
    _id_4004();
  }
}

#using_animtree("generic_human");

_id_4004() {
  var_0 = [];
  var_0["traverseAnim"] = % slide_across_car;
  var_0["traverseToCoverAnim"] = % slide_across_car_2_cover;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 38.0;
  var_0["interruptDeathAnim"][0] = animscripts\utility::_id_0C6D( % slide_across_car_death);
  var_0["traverseSound"] = "npc_car_slide_hood";
  var_0["traverseToCoverSound"] = "npc_car_slide_cover";
  animscripts\traverse\shared::_id_3FEB(var_0);
}

#using_animtree("dog");

_id_4005() {
  self endon("killanimscript");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim( % root, 0.1);
  self setflaggedanimrestart("traverse", anim._id_3AF6["jump_up_40"], 1, 0.1, 1);
  animscripts\shared::_id_0C51("traverse");
  thread common_scripts\utility::play_sound_in_space("anml_dog_bark", self gettagorigin("tag_eye"));
  self clearanim( % root, 0);
  self setflaggedanimrestart("traverse", anim._id_3AF6["jump_down_40"], 1, 0, 1);
  animscripts\shared::_id_0C51("traverse");
  self traversemode("gravity");
  self._id_3B58 = 1;
}