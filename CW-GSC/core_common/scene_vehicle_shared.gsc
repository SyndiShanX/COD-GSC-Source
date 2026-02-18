/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\scene_vehicle_shared.gsc
************************************************/

#using scripts\core_common\scene_objects_shared;
#using scripts\core_common\vehicle_ai_shared;
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

    if(!is_true(_e.skipscenedeath)) {
      csceneobject::function_1e19d813();
    }
  }

  function _spawn_ent() {
    if(isDefined(_s.model)) {
      if(isassetloaded("vehicle", _s.model)) {
        _e = spawnvehicle(_s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), undefined, 0, undefined, _s.var_6b8decce, _s.var_4f56e47a, _s.var_3b48be8d);

        if(isDefined(_e)) {
          scene::prepare_generic_model_anim(_e);
        }
      }
    }
  }

  function _cleanup() {
    if(isDefined(_e) && _e vehicle_ai::has_state("scripted")) {
      _e vehicle_ai::stop_scripted(_e.var_24bb7024);
    }
  }

  function _set_values(ent = self._e) {
    if(!csceneobject::error(!isvehicle(ent) && ent.classname !== "script_model", "entity is not actually a Vehicle or script_model, but set to Vehicle in scene. Check the GDT to make sure the proper object type is set")) {
      scene::prepare_generic_model_anim(ent);
    }

    csceneobject::set_ent_val("takedamage", is_true(_s.takedamage), ent);
    csceneobject::set_ent_val("ignoreme", !is_true(_s.attackme), ent);
    csceneobject::set_ent_val("allowdeath", is_true(_s.allowdeath), ent);
  }

  function _prepare() {
    csceneobject::set_objective();

    if(isDefined(_e) && _e vehicle_ai::has_state("scripted")) {
      _e.var_24bb7024 = _e vehicle_ai::get_current_state();
      _e vehicle_ai::start_scripted();
    }
  }

}