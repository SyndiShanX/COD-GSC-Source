/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_weap_bouncingbetty.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\bouncingbetty;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_placeable_mine;

#namespace bouncingbetty;

autoexec __init__system__() {
  system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

__init__() {
  level._proximityweaponobjectdetonation_override = &proximityweaponobjectdetonation_override;
  init_shared();
  zm_placeable_mine::add_mine_type("bouncingbetty", #"zombie/betty_pickup");
  level.bettyjumpheight = 55;
  level.bettydamagemax = 1000;
  level.bettydamagemin = 800;
  level.bettydamageheight = level.bettyjumpheight;

  setdvar(#"betty_damage_max", level.bettydamagemax);
  setdvar(#"betty_damage_min", level.bettydamagemin);
  setdvar(#"betty_jump_height_onground", level.bettyjumpheight);

}

proximityweaponobjectdetonation_override(watcher) {
  self endon(#"death", #"hacked", #"kill_target_detection");
  weaponobjects::proximityweaponobject_activationdelay(watcher);
  damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
  up = anglestoup(self.angles);
  traceorigin = self.origin + up;

  while(true) {
    waitresult = damagearea waittill(#"trigger");
    ent = waitresult.activator;

    if(!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent)) {
      continue;
    }

    if(weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent)) {
      continue;
    }

    if(ent damageconetrace(traceorigin, self) > 0) {
      thread weaponobjects::proximityweaponobject_dodetonation(watcher, ent, traceorigin);
    }
  }
}