/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\load.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace load;

main() {
  assert(isDefined(level.first_frame), "<dev string:x38>");
  level._loadstarted = 1;

  util::check_art_mode();

  util::apply_dev_overrides();

    setclearanceceiling(30);
  register_clientfields();
  level.aitriggerspawnflags = getaitriggerflags();
  level.vehicletriggerspawnflags = getvehicletriggerflags();
  setup_traversals();
  level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
  level.growing_hitmarker = 1;
  system::wait_till("all");
  level flagsys::set(#"load_main_complete");
}

setfootstepeffect(name, fx) {
  assert(isDefined(name), "<dev string:x66>");
  assert(isDefined(fx), "<dev string:x92>");

  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
  level._effect["step_" + name] = fx;
}

footsteps() {
  setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
  setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
  setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

init_traverse() {
  point = getent(self.target, "targetname");

  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
    point delete();
    return;
  }

  point = struct::get(self.target, "targetname");

  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
  }
}

setup_traversals() {
  potential_traverse_nodes = getallnodes();

  for(i = 0; i < potential_traverse_nodes.size; i++) {
    node = potential_traverse_nodes[i];

    if(node.type == #"begin") {
      node init_traverse();
    }
  }
}

register_clientfields() {
  clientfield::register("missile", "cf_m_proximity", 1, 1, "int");
  clientfield::register("missile", "cf_m_emp", 1, 1, "int");
  clientfield::register("missile", "cf_m_stun", 1, 1, "int");
}