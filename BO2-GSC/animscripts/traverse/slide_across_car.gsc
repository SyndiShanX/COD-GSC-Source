/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\slide_across_car.gsc
*****************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include maps\_utility;
#include animscripts\anims;
#include animscripts\shared;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    case "dog":
      dog();
      break;
    default:

      assertmsg("Traversal: 'mantle_over_40' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("slide_across_car", "move");
  traversedata["traverseToCoverAnim"] = animarray("slide_across_car_to_cover", "move");
  traversedata["coverType"] = "Cover Crouch";
  traversedata["traverseHeight"] = 38.0;
  traversedata["interruptDeathAnim"][0] = array(animarray("slide_across_car_death", "move"));
  traversedata["traverseSound"] = "npc_car_slide_hood";
  traversedata["traverseToCoverSound"] = "npc_car_slide_cover";
  dotraverse(traversedata);
}

#using_animtree("dog");

dog() {
  self endon("killanimscript");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self clearanim( % root, 0.1);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_up_40"], 1, 0.1, 1);
  self animscripts\shared::donotetracks("traverse");
  self thread play_sound_in_space("aml_dog_bark", self gettagorigin("tag_eye"));
  self clearanim( % root, 0);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_down_40"], 1, 0, 1);
  self animscripts\shared::donotetracks("traverse");
  self traversemode("gravity");
  self.traversecomplete = 1;
}