/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\barricades_shared.gsc
***********************************************/

#include scripts\core_common\doors_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;

#namespace barricades;

class cbarricade: cdoor {
  var m_e_door;
  var m_s_bundle;
  var m_str_type;
  var var_a2f96f78;

  constructor() {
    m_str_type = "barricade";
  }

  function function_6c15ac46() {
    m_e_door endon(#"delete", #"barricade_removed");

    while(true) {
      m_e_door endon(#"delete");
      m_e_door waittill(#"hash_923096b653062ea");

      if(isDefined(var_a2f96f78.target)) {
        var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");

        foreach(s_door in var_59746f25) {
          s_door.c_door.var_7d28591d = 0;
        }
      }

      waitframe(1);
    }
  }

  function function_da5abae9() {
    m_e_door endon(#"delete", #"barricade_removed");

    while(true) {
      m_e_door waittill(#"hash_7166c13e79b73f9");

      if(isDefined(var_a2f96f78.target)) {
        var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");

        foreach(s_door in var_59746f25) {
          s_door.c_door.var_7d28591d = 1;

          if([
              [s_door.c_door]
            ] - > is_open()) {
            [
              [s_door.c_door]
            ] - > close();
          }
        }
      }

      waitframe(1);
    }
  }

  function function_b4a1f06a() {
    m_e_door endon(#"delete");

    if(!isDefined(m_s_bundle.var_89af4052)) {
      m_s_bundle.var_89af4052 = 0;
    }

    var_1913ccf5 = m_s_bundle.var_89af4052;

    while(true) {
      m_e_door waittill(#"damage");

      if(cdoor::is_open()) {
        var_1913ccf5--;

        if(var_1913ccf5 < 0) {
          var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");

          foreach(s_door in var_59746f25) {
            s_door.c_door.var_7d28591d = 0;
          }

          if(isDefined(m_s_bundle.var_170e4611) && m_s_bundle.var_170e4611) {
            if(isDefined(m_s_bundle.var_8124c17f)) {
              m_e_door scene::play(m_s_bundle.var_8124c17f, m_e_door);
            }

            m_e_door notify(#"gameobject_deleted");
            m_e_door notify(#"barricade_removed");
            waitframe(1);
            m_e_door.mdl_gameobject delete();
            m_e_door delete();
            break;
          } else {
            if(cdoor::is_open()) {
              cdoor::close();
            }

            var_1913ccf5 = m_s_bundle.var_89af4052;
          }
        }
      }

      waitframe(1);
    }
  }

  function init(var_4a686ff8, s_instance) {
    m_s_bundle = var_4a686ff8;
    var_a2f96f78 = s_instance;
    m_s_bundle.door_start_open = s_instance.door_start_open;
    s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);

    if(isDefined(m_s_bundle.door_start_open) && m_s_bundle.door_start_open) {
      if(isDefined(var_a2f96f78.target)) {
        var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");

        foreach(s_door in var_59746f25) {
          s_door.c_door.var_7d28591d = 1;

          if([
              [s_door.c_door]
            ] - > is_open()) {
            [
              [s_door.c_door]
            ] - > close();
          }
        }
      }
    }

    if(isDefined(m_s_bundle.var_ccc6dafc) && m_s_bundle.var_ccc6dafc) {
      m_e_door setCanDamage(1);
      m_e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 0);
      thread function_b4a1f06a();
    }

    thread function_da5abae9();
    thread function_6c15ac46();
  }

}

autoexec __init__system__() {
  system::register(#"barricades", &__init__, &__main__, undefined);
}

__init__() {
  if(!isDefined(level.a_s_barricades)) {
    level.a_s_barricades = [];
  }

  level.a_s_barricades = struct::get_array("scriptbundle_barricades", "classname");

  foreach(s_instance in level.a_s_barricades) {
    c_door = s_instance function_14354831();

    if(isDefined(c_door)) {
      s_instance.c_door = c_door;
    }
  }
}

function_14354831() {
  if(isDefined(self.scriptbundlename)) {
    var_9fecaae1 = struct::get_script_bundle("barricades", self.scriptbundlename);
  }

  var_2a44a7ed = new cbarricade();
  var_2a44a7ed = [[var_2a44a7ed]] - > init(var_9fecaae1, self);
  return var_2a44a7ed;
}

__main__() {
  level flagsys::wait_till("radiant_gameobjects_initialized");
}