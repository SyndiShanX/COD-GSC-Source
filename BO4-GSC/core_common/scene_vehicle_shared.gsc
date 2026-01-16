/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scene_vehicle_shared.gsc
************************************************/

#include scripts\core_common\scene_objects_shared;

#namespace scene;

class cscenevehicle: csceneobject {
  var _e;
  var _o_scene;
  var _s;
  var var_1f97724a;

  function function_d09b043() {
    self notify(#"hash_3451c0bca5c1ca69");
    self endon(#"hash_3451c0bca5c1ca69");
    _o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
    s_waitresult = _e waittill(#"death");
    var_1f97724a = 1;
    _e notify(#"hash_6e7fd8207fd988c6", {
      #str_scene: _o_scene._str_name
    });
    csceneobject::function_1e19d813();
  }

  function _cleanup() {}

  function _prepare() {
    csceneobject::set_objective();
  }

  function _set_values(ent = self._e) {
    if(!csceneobject::error(!isvehicle(ent) && ent.classname !== "script_model", "entity is not actually a Vehicle or script_model, but set to Vehicle in scene. Check the GDT to make sure the proper object type is set")) {
      scene::prepare_generic_model_anim(ent);
    }

    csceneobject::set_ent_val("takedamage", isDefined(_s.takedamage) && _s.takedamage, ent);
    csceneobject::set_ent_val("ignoreme", !(isDefined(_s.attackme) && _s.attackme), ent);
    csceneobject::set_ent_val("allowdeath", isDefined(_s.allowdeath) && _s.allowdeath, ent);
  }

  function _spawn_ent() {
    if(isDefined(_s.model)) {
      if(isassetloaded("vehicle", _s.model)) {
        _e = spawnvehicle(_s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
        scene::prepare_generic_model_anim(_e);
      }
    }
  }

}