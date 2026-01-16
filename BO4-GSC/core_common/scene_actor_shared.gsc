/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scene_actor_shared.gsc
***********************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_actor_shared;
#include scripts\core_common\scene_objects_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\util_shared;

#namespace scene;

class csceneactor: csceneobject {
  var _b_set_goal;
  var _e;
  var _o_scene;
  var _s;
  var _str_shot;
  var _str_team;
  var var_1f97724a;
  var var_55b4f21e;

  constructor() {
    _b_set_goal = 1;
  }

  function do_death_anims() {
    ent = _e;

    if(isDefined(var_55b4f21e.deathanim) && !(isDefined(ent.var_67d418) && ent.var_67d418)) {
      ent.skipdeath = 1;
      ent animation::play(var_55b4f21e.deathanim, ent, undefined, 1, 0.2, 0);
    } else {
      ent animation::stop();
      ent startragdoll();
    }

    csceneobject::function_1e19d813();
  }

  function _set_values(ent = self._e) {
    if(!(isDefined(_s.takedamage) && _s.takedamage)) {
      csceneobject::set_ent_val("takedamage", 0, ent);
    }

    csceneobject::set_ent_val("ignoreme", !(isDefined(_s.attackme) && _s.attackme), ent);
    csceneobject::set_ent_val("allowdeath", isDefined(_s.allowdeath) && _s.allowdeath, ent);
    csceneobject::set_ent_val("take_weapons", isDefined(_s.removeweapon) && _s.removeweapon, ent);
  }

  function function_d09b043() {
    self notify(#"hash_74f6d3a1ddcff42");
    self endon(#"hash_74f6d3a1ddcff42");
    _o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
    s_waitresult = _e waittill(#"death");
    var_1f97724a = 1;
    _e notify(#"hash_6e7fd8207fd988c6", {
      #str_scene: _o_scene._str_name
    });

    if(isDefined(_e) && !(isDefined(_e.skipscenedeath) && _e.skipscenedeath)) {
      self thread do_death_anims();
      return;
    }

    csceneobject::function_1e19d813();
  }

  function set_goal() {
    if(!(_e.scene_spawned === _o_scene._s.name && isDefined(_e.target))) {
      if(!isDefined(_e.script_forcecolor)) {
        if(!_e flagsys::get(#"anim_reach")) {
          if(isDefined(_e.scenegoal)) {
            _e setgoal(_e.scenegoal);
            _e.scenegoal = undefined;
            return;
          }

          if(_b_set_goal) {
            _e setgoal(_e.origin);
          }
        }
      }
    }
  }

  function track_goal() {
    self endon(_str_shot + "active");
    _e endon(#"death");
    _e waittill(#"goal_changed");
    _b_set_goal = 0;
  }

  function _cleanup() {
    if(isactor(_e) && isalive(_e)) {
      if(isDefined(_s.delaymovementatend) && _s.delaymovementatend) {
        _e pathmode("move delayed", 1, randomfloatrange(2, 3));
      } else {
        _e pathmode("move allowed");
      }

      if(isDefined(_s.lookatplayer) && _s.lookatplayer) {
        _e lookatentity();
      }

      _e.var_67d418 = undefined;
      set_goal();
    }
  }

  function _prepare() {
    if(isactor(_e)) {
      thread track_goal();

      if(isDefined(_s.lookatplayer) && _s.lookatplayer) {
        _e lookatentity(level.activeplayers[0]);
      }

      if(isDefined(_s.skipdeathanim) && _s.skipdeathanim) {
        _e.var_67d418 = 1;
      }

      _str_team = _e getteam();
    }

    csceneobject::_prepare();
  }

  function function_bc340efa(str_model) {
    _e = spawnactor(str_model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), undefined, 1);

    if(!isDefined(_e)) {
      return;
    }

    _str_team = _e getteam();
    _e setteam(_str_team);
  }

  function _spawn_ent() {
    if(isDefined(_s.model)) {
      if(isassetloaded("aitype", _s.model)) {
        function_bc340efa(_s.model);
      }
    }
  }

}

class cscenefakeactor: csceneobject, csceneactor {
  var _e;
  var _s;
  var _str_team;

  function _spawn_ent() {
    if(isspawner(_e)) {
      csceneactor::function_bc340efa(_e.aitype);

      if(isDefined(_e) && !isspawner(_e)) {
        str_model = _e.aitype;
        _str_team = _e getteam();
        weapon = _e.weapon;
        _e delete();
      }
    } else if(isDefined(_s.model)) {
      if(isassetloaded("aitype", _s.model)) {
        csceneactor::function_bc340efa(_s.model);

        if(isDefined(_e)) {
          str_model = _e.aitype;
          _str_team = _e getteam();
          weapon = _e.weapon;
          _e delete();
        }
      } else {
        str_model = _s.model;
      }
    }

    if(isDefined(str_model)) {
      _e = util::spawn_anim_model(str_model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
      _e makefakeai();

      if(!(isDefined(_s.removeweapon) && _s.removeweapon)) {
        if(isDefined(weapon)) {
          _e animation::attach_weapon(weapon);
          return;
        }

        _e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
      }
    }
  }

}

class cscenecompanion: csceneobject, csceneactor {
  var _e;
  var _o_scene;
  var _s;
  var _str_shot;
  var _str_team;

  function animation_lookup(animation, ent = self._e, b_camera = 0) {
    if(isDefined(_s.var_2df1a365)) {
      n_shot = csceneobject::get_shot(_str_shot);
      var_d57bf586 = ent.animname;

      if(isDefined(n_shot) && isDefined(_s.var_2df1a365[n_shot]) && isDefined(_s.var_2df1a365[n_shot][var_d57bf586])) {
        return _s.var_2df1a365[n_shot][var_d57bf586].var_554345e4;
      }
    }

    return animation;
  }

  function _stop(b_dont_clear_anim) {
    if(isalive(_e)) {
      _e notify(#"scene_stop");

      if(!b_dont_clear_anim) {
        _e animation::stop(0.2);
      }

      _e thread scene::function_37592f67(_o_scene._e_root, _o_scene._s);
    }
  }

  function _cleanup() {
    if(![
        [_o_scene]
      ] - > has_next_shot(_str_shot) || _o_scene._str_mode === "single") {
      _e thread scene::function_37592f67(_o_scene._e_root, _o_scene._s);
    }
  }

  function _spawn_ent() {
    if(isspawner(_e)) {
      if(!csceneobject::error(_e.count < 1, "Trying to spawn AI for scene with spawner count < 1")) {
        _e = _e spawner::spawn(1);
      }
    } else if(isassetloaded("aitype", _s.model)) {
      _e = spawnactor(_s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), _s.name, 1);
    }

    if(!isDefined(_e)) {
      return;
    }

    _str_team = _e getteam();

    if(!isDefined(level.heroes)) {
      level.heroes = [];
    }

    level.heroes[_s.name] = _e;
    _s.(_s.name) = _e;
    _e.animname = _s.name;
    _e.is_hero = 1;
    _e.enableterrainik = 1;
    _e util::magic_bullet_shield();
  }

  function _spawn() {
    if(!isDefined(level.heroes)) {
      level.heroes = [];
    }

    foreach(ent in level.heroes) {
      if(!csceneobject::in_this_scene(ent)) {
        _e = ent;
        return;
      }
    }

    csceneobject::_spawn();
  }

}

class cscenesharedcompanion: cscenecompanion, csceneobject, csceneactor {

  function _cleanup() {
    if(!isDefined(level.heroes)) {
      level.heroes = [];
    }

    foreach(ent in level.heroes) {
      ent setvisibletoall();
    }

    cscenecompanion::_cleanup();
  }

  function _prepare() {
    if(!isDefined(level.heroes)) {
      level.heroes = [];
    }

    foreach(ent in level.heroes) {
      ent setinvisibletoall();
      ent setvisibletoall();
    }
  }

}