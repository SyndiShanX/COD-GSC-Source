/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\scene_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_debug_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\scriptbundle_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using_animtree("all_player");
#using_animtree("generic");

class csceneobject: cscriptbundleobjectbase {
  var current_playing_anim;
  var _s;
  var _e;
  var _o_bundle;
  var _str_name;
  var _player;
  var player_animation;
  var player_animation_notify;
  var player_start_time;
  var player_time_frac;
  var player_animation_length;
  var player_rate;
  var player_tag;
  var player_align;
  var _is_valid;
  var _b_set_goal;
  var _str_death_anim;
  var _str_death_anim_loop;
  var _str_state;
  var _b_spawnonce_used;

  constructor() {
    _is_valid = 1;
    _b_spawnonce_used = 0;
    _b_set_goal = 1;
  }

  destructor() {}

  function skip_scene(b_wait_one_frame) {
    if(isDefined(b_wait_one_frame)) {
      wait(0.05);
    }
    if(skip_scene_on_client()) {
      wait(0.05);
    }
    skip_scene_on_server();
  }

  function skip_scene_on_server() {
    if(isDefined(current_playing_anim)) {
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.mainanim) + "") + gettime(), (1, 1, 1));
      }
      if(is_shared_player()) {
        foreach(player in level.players) {
          skip_anim_on_server(player, current_playing_anim[player getentitynumber()]);
        }
      } else {
        skip_anim_on_server(_e, current_playing_anim);
      }
    }
  }

  function skip_scene_on_client() {
    if(isDefined(current_playing_anim)) {
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.mainanim) + "") + gettime(), vectorscale((1, 1, 1), 0.8));
      }
      if(is_shared_player()) {
        foreach(player in level.players) {
          skip_anim_on_client(player, current_playing_anim[player getentitynumber()]);
        }
      } else {
        skip_anim_on_client(_e, current_playing_anim);
      }
      return true;
    }
    return false;
  }

  function private skip_anim_on_server(entity, anim_name) {
    if(!isDefined(anim_name)) {
      return;
    }
    if(!isDefined(entity)) {
      return;
    }
    if(!entity isplayinganimscripted()) {
      return;
    }
    is_looping = isanimlooping(anim_name);
    if(is_looping) {
      entity animation::stop();
    } else {
      entity setanimtimebyname(anim_name, 1);
    }
    entity stopsounds();
  }

  function private skip_anim_on_client(entity, anim_name) {
    if(!isDefined(anim_name)) {
      return;
    }
    if(!isDefined(entity)) {
      return;
    }
    if(!entity isplayinganimscripted()) {
      return;
    }
    is_looping = isanimlooping(anim_name);
    if(is_looping) {
      return;
    }
    entity clientfield::increment("player_scene_animation_skip");
  }

  function _should_skip_entity() {
    if(!(isDefined(_s.player) && _s.player) && (!(isDefined(_s.sharedigc) && _s.sharedigc)) && (!(isDefined(_s.keepwhileskipping) && _s.keepwhileskipping)) && (isDefined([
        [_o_bundle]
      ] - > is_skipping_scene()) && [
        [_o_bundle]
      ] - > is_skipping_scene()) && (isDefined(_s.deletewhenfinished) && _s.deletewhenfinished)) {
      if(isDefined(_s.initanim) && animhasimportantnotifies(_s.initanim)) {
        return false;
      }
      if(isDefined(_s.mainanim) && animhasimportantnotifies(_s.mainanim)) {
        return false;
      }
      if(isDefined(_s.endanim) && animhasimportantnotifies(_s.endanim)) {
        return false;
      }
      if(!isspawner(_e)) {
        b_allows_multiple = [[scene()]] - > allows_multiple();
        e = scene::get_existing_ent(_str_name, b_allows_multiple);
        if(isDefined(e)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  function _should_skip_anim(animation) {
    if(!(isDefined(_s.player) && _s.player) && (!(isDefined(_s.sharedigc) && _s.sharedigc)) && (!(isDefined(_s.keepwhileskipping) && _s.keepwhileskipping)) && (isDefined([
        [_o_bundle]
      ] - > is_skipping_scene()) && [
        [_o_bundle]
      ] - > is_skipping_scene()) && (isDefined(_s.deletewhenfinished) && _s.deletewhenfinished)) {
      if(!animhasimportantnotifies(animation)) {
        if(!isspawner(_e)) {
          b_allows_multiple = [
            [scene()]
          ] - > allows_multiple();
          e = scene::get_existing_ent(_str_name, b_allows_multiple);
          if(isDefined(e)) {
            return false;
          }
        }
        return true;
      }
    }
    return false;
  }

  function in_a_different_scene() {
    return isDefined(_e) && isDefined(_e.current_scene) && _e.current_scene != _o_bundle._str_name;
  }

  function is_shared_player() {
    return isDefined(_s.player) && (isDefined(_s.sharedigc) && _s.sharedigc);
  }

  function is_player_model() {
    return _s.type === "player model";
  }

  function is_player() {
    return isDefined(_s.player);
  }

  function is_alive() {
    return isDefined(_e) && (_e.health > 0 || _s.ignorealivecheck === 1);
  }

  function has_init_state() {
    return _s scene::_has_init_state();
  }

  function reset_player() {
    level flag::wait_till("all_players_spawned");
    player = _player;
    player enableusability();
    player enableoffhandweapons();
    player enableweapons();
    player show();
  }

  function link_player() {
    self endon("done");
    level flag::wait_till("all_players_spawned");
    player = _player;
    player hide();
    e_linked = player getlinkedent();
    if(isDefined(e_linked) && e_linked == _e) {
      if(isDefined(_s.lockview) && _s.lockview) {
        player playerlinktoabsolute(_e, "tag_player");
      } else {
        loc_0000659A: loc_000065C2: loc_000065EA: player lerpviewangleclamp(0.2, 0.1, 0.1, (isDefined(_s.viewclampright) ? _s.viewclampright : 0), (isDefined(_s.viewclampleft) ? _s.viewclampleft : 0), (isDefined(_s.viewclamptop) ? _s.viewclamptop : 0), (isDefined(_s.viewclampbottom) ? _s.viewclampbottom : 0));
      }
      return;
    }
    player disableusability();
    player disableoffhandweapons();
    player disableweapons();
    util::wait_network_frame();
    player notify("scene_link", _s.cameratween > 0);
    waittillframeend();
    if(isDefined(_s.lockview) && _s.lockview) {
      player playerlinktoabsolute(_e, "tag_player");
    } else {
      loc_0000673A: loc_00006762: loc_0000678A: player playerlinktodelta(_e, "tag_player", 1, (isDefined(_s.viewclampright) ? _s.viewclampright : 0), (isDefined(_s.viewclampleft) ? _s.viewclampleft : 0), (isDefined(_s.viewclamptop) ? _s.viewclamptop : 0), (isDefined(_s.viewclampbottom) ? _s.viewclampbottom : 0), 1, 1);
    }
    wait((_s.cameratween > 0.2 ? _s.cameratween : 0.2));
    _e show();
  }

  function get_camera_tween_out() {
    return true;
  }

  function get_camera_tween() {
    return true;
  }

  function get_lerp_time() {
    if(isplayer(_e)) {
      return true;
    }
    return true;
  }

  function regroup_invulnerability(e_player) {
    e_player endon("disconnect");
    e_player.ignoreme = 1;
    e_player.b_teleport_invulnerability = 1;
    e_player util::streamer_wait(undefined, 0, 7);
    e_player.ignoreme = 0;
    e_player.b_teleport_invulnerability = undefined;
  }

  function play_regroup_fx_for_scene(e_player) {
    align = get_align_ent();
    v_origin = align.origin;
    v_angles = align.angles;
    tag = get_align_tag();
    if(isDefined(tag)) {
      v_origin = align gettagorigin(tag);
      v_angles = align gettagangles(tag);
    }
    v_start = getstartorigin(v_origin, v_angles, _s.mainanim);
    n_dist_sq = distancesquared(e_player.origin, v_start);
    if(n_dist_sq > 250000 || isDefined(e_player.hijacked_vehicle_entity) && (!(isDefined(e_player.force_short_scene_transition_effect) && e_player.force_short_scene_transition_effect))) {
      self thread regroup_invulnerability(e_player);
      e_player clientfield::increment_to_player("postfx_igc", 1);
    } else {
      e_player clientfield::increment_to_player("postfx_igc", 3);
    }
    util::wait_network_frame();
  }

  function _play_shared_player_anim_for_player(player) {
    player endon("death");
    if(getdvarint("") > 0) {
      printtoprightln("" + player_animation);
    }
    if(!isDefined(_o_bundle)) {
      return;
    }
    player flagsys::set("shared_igc");
    if(player flagsys::get(player_animation_notify)) {
      player flagsys::set(player_animation_notify + "_skip_init_clear");
    }
    player flagsys::set(player_animation_notify);
    if(isDefined(player getlinkedent())) {
      player unlink();
    }
    if(!(isDefined(_s.disabletransitionin) && _s.disabletransitionin)) {
      if(player != _player || getdvarint("scr_player1_postfx", 0)) {
        if(!isDefined(player.screen_fade_menus)) {
          if(!(isDefined(level.chyron_text_active) && level.chyron_text_active)) {
            if(!(isDefined(player.fullscreen_black_active) && player.fullscreen_black_active)) {
              player.play_scene_transition_effect = 1;
            }
          }
        }
      }
    }
    player show();
    player setinvisibletoall();
    _prepare_player(player);
    n_time_passed = (gettime() - player_start_time) / 1000;
    n_start_time = player_time_frac * player_animation_length;
    n_time_left = (player_animation_length - n_time_passed) - n_start_time;
    n_time_frac = 1 - (n_time_left / player_animation_length);
    if(isDefined(_e) && player != _e) {
      player dontinterpolate();
      player setorigin(_e.origin);
      player setplayerangles(_e getplayerangles());
    }
    n_lerp = get_lerp_time();
    if(!_o_bundle._s scene::is_igc()) {
      n_camera_tween = get_camera_tween();
      if(n_camera_tween > 0) {
        player startcameratween(n_camera_tween);
      }
    }
    if(n_time_frac < 1) {
      if(getdvarint("") > 0) {
        player hide();
      }
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.name) + "") + player_animation);
      }
      str_animation = player_animation;
      if(player util::is_female()) {
        if(isDefined(_o_bundle._s.s_female_bundle)) {
          s_bundle = _o_bundle._s.s_female_bundle;
        }
      } else if(isDefined(_o_bundle._s.s_male_bundle)) {
        s_bundle = _o_bundle._s.s_male_bundle;
      }
      if(isDefined(s_bundle)) {
        foreach(s_object in s_bundle.objects) {
          if(isDefined(s_object) && s_object.type === "player") {
            str_animation = s_object.mainanim;
            break;
          }
        }
      }
      player_num = player getentitynumber();
      if(!isDefined(current_playing_anim)) {
        current_playing_anim = [];
      }
      current_playing_anim[player_num] = str_animation;
      if(isDefined([[_o_bundle]] - > is_skipping_scene()) && [[_o_bundle]] - > is_skipping_scene()) {
        thread skip_scene(1);
      }
      player animation::play(str_animation, player_align, player_tag, player_rate, 0, 0, n_lerp, n_time_frac, _s.showweaponinfirstperson);
      if(!player flagsys::get(player_animation_notify + "_skip_init_clear")) {
        player flagsys::clear(player_animation_notify);
      } else {
        player flagsys::clear(player_animation_notify + "_skip_init_clear");
      }
      if(!player isplayinganimscripted()) {
        current_playing_anim[player_num] = undefined;
      }
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.name) + "") + player_animation);
      }
    }
  }

  function _play_shared_player_anim(animation, align, tag, n_rate, n_time) {
    if(getdvarint("") > 0) {
      printtoprightln("" + animation);
    }
    player_animation = animation;
    player_animation_notify = animation + "_notify";
    player_animation_length = getanimlength(animation);
    player_align = align;
    player_tag = tag;
    player_rate = n_rate;
    player_time_frac = n_time;
    player_start_time = gettime();
    callback::on_loadout(&_play_shared_player_anim_for_player, self);
    foreach(player in level.players) {
      if(player flagsys::get("loadout_given") && player.sessionstate !== "spectator") {
        self thread _play_shared_player_anim_for_player(player);
        continue;
      }
      if(isDefined(player.initialloadoutgiven) && player.initialloadoutgiven) {
        revive_player(player);
      }
    }
    waittillframeend();
    do {
      b_playing = 0;
      a_players = arraycopy(level.activeplayers);
      foreach(player in a_players) {
        if(isDefined(player) && player flagsys::get(player_animation_notify)) {
          b_playing = 1;
          player flagsys::wait_till_clear(player_animation_notify);
          break;
        }
      }
    }
    while(b_playing);
    callback::remove_on_loadout(&_play_shared_player_anim_for_player, self);
    thread[[_o_bundle]] - > _call_state_funcs("players_done");
  }

  function spawn_ent(e) {
    b_disable_throttle = _o_bundle._s scene::is_igc() || (isDefined(_o_bundle._s.dontthrottle) && _o_bundle._s.dontthrottle);
    if(is_player() && (!(isDefined(_s.newplayermethod) && _s.newplayermethod))) {
      system::wait_till("loadout");
      m_player = util::spawn_anim_model(level.player_interactive_model);
      return m_player;
    }
    if(isDefined(e)) {
      if(isspawner(e)) {
        if(_o_bundle._testing) {
          e.count++;
        }
        if(!cscriptbundleobjectbase::error(e.count < 1, "Trying to spawn AI for scene with spawner count < 1")) {
          return e spawner::spawn(1, undefined, undefined, undefined, b_disable_throttle);
        }
      }
    } else if(isDefined(_s.model)) {
      new_model = undefined;
      if(is_player_model()) {
        new_model = util::spawn_anim_player_model(_s.model, _o_bundle._e_root.origin, _o_bundle._e_root.angles);
      } else {
        new_model = util::spawn_anim_model(_s.model, _o_bundle._e_root.origin, _o_bundle._e_root.angles, undefined, !b_disable_throttle);
      }
      return new_model;
    }
  }

  function _play_anim(animation, n_delay_min = 0, n_delay_max = 0, n_rate = 1, n_blend = 0.2, n_time = 0) {
    if(getdvarint("") > 0) {
      if(isDefined(_s.name)) {
        printtoprightln("" + _s.name);
      } else {
        printtoprightln("" + _s.model);
      }
    }
    if(_should_skip_anim(animation)) {
      return;
    }
    if(n_time != 0) {
      n_time = [
        [_o_bundle]
      ] - > get_anim_relative_start_time(animation, n_time);
    }
    n_delay = n_delay_min;
    if(n_delay_max > n_delay_min) {
      n_delay = randomfloatrange(n_delay_min, n_delay_max);
    }
    do_reach = n_time == 0 && (isDefined(_s.doreach) && _s.doreach && (!(isDefined(_o_bundle._testing) && _o_bundle._testing) || getdvarint("scene_test_with_reach", 0)));
    _spawn(undefined, !do_reach, !do_reach);
    if(!isactor(_e)) {
      do_reach = 0;
    }
    if(n_delay > 0) {
      if(n_delay > 0) {
        wait(n_delay);
      }
    }
    if(do_reach) {
      [
        [scene()]
      ] - > wait_till_scene_ready(self);
      if(isDefined(_s.disablearrivalinreach) && _s.disablearrivalinreach) {
        _e animation::reach(animation, get_align_ent(), get_align_tag(), 1);
      } else {
        _e animation::reach(animation, get_align_ent(), get_align_tag());
      }
      flagsys::set("ready");
    } else {
      if(n_rate > 0) {
        [[scene()]] - > wait_till_scene_ready();
      } else if(isDefined(_s.aligntarget)) {
        foreach(o_obj in _o_bundle._a_objects) {
          if(o_obj._str_name == _s.aligntarget) {
            o_obj flagsys::wait_till("ready");
            break;
          }
        }
      }
    }
    if(is_alive()) {
      align = get_align_ent();
      tag = get_align_tag();
      if(align == level) {
        align = (0, 0, 0);
        tag = (0, 0, 0);
      }
      if(is_shared_player()) {
        _play_shared_player_anim(animation, align, tag, n_rate, n_time);
      } else {
        if(is_player() && (!(isDefined(_s.newplayermethod) && _s.newplayermethod))) {
          thread link_player();
        }
        if(_o_bundle._s scene::is_igc() || _e.scene_spawned === _o_bundle._s.name) {
          _e dontinterpolate();
          _e show();
        }
        n_lerp = get_lerp_time();
        if(isplayer(_e) && !_o_bundle._s scene::is_igc()) {
          n_camera_tween = get_camera_tween();
          if(n_camera_tween > 0) {
            _e startcameratween(n_camera_tween);
          }
        }
        if(![
            [_o_bundle]
          ] - > has_next_scene()) {
          n_blend_out = (isai(_e) ? 0.2 : 0);
        } else {
          n_blend_out = 0;
        }
        if(isDefined(_s.diewhenfinished) && _s.diewhenfinished) {
          n_blend_out = 0;
        }
        if(getdvarint("") > 0) {
          printtoprightln((("" + (isDefined(_s.name) ? _s.name : _s.model)) + "") + animation);
        }
        if(getdvarint("") > 0) {
          if(!isDefined(level.animation_played)) {
            level.animation_played = [];
            animation_played_name = ((isDefined(_s.name) ? _s.name : _s.model) + "") + animation;
            if(!isDefined(level.animation_played)) {
              level.animation_played = [];
            } else if(!isarray(level.animation_played)) {
              level.animation_played = array(level.animation_played);
            }
            level.animation_played[level.animation_played.size] = animation_played_name;
          }
        }
        current_playing_anim = animation;
        if(isDefined([
            [_o_bundle]
          ] - > is_skipping_scene()) && [
            [_o_bundle]
          ] - > is_skipping_scene() && n_rate != 0) {
          thread skip_scene(1);
        }
        _e animation::play(animation, align, tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, _s.showweaponinfirstperson);
        if(!isDefined(_e) || !_e isplayinganimscripted()) {
          self.current_playing_anim = undefined;
        }
        if(getdvarint("") > 0) {
          if(isDefined(level.animation_played)) {
            for(i = 0; i < level.animation_played.size; i++) {
              animation_played_name = ((isDefined(_s.name) ? _s.name : _s.model) + "") + animation;
              if(level.animation_played[i] == animation_played_name) {
                arrayremovevalue(level.animation_played, animation_played_name);
                i--;
                continue;
              }
            }
          }
        }
        if(getdvarint("") > 0) {
          printtoprightln((("" + (isDefined(_s.name) ? _s.name : _s.model)) + "") + animation);
        }
      }
    } else {
      cscriptbundleobjectbase::log(("" + animation) + "");
    }
    _is_valid = is_alive() && !in_a_different_scene();
  }

  function _track_goal() {
    self endon("cleanup");
    _e endon("death");
    _e waittill("goal_changed");
    _b_set_goal = 0;
  }

  function _set_goal() {
    if(!(_e.scene_spawned === _o_bundle._s.name && isDefined(_e.target))) {
      if(!isDefined(_e.script_forcecolor)) {
        if(!_e flagsys::get("anim_reach")) {
          if(isDefined(_e.scenegoal)) {
            _e setgoal(_e.scenegoal);
            _e.scenegoal = undefined;
          } else if(_b_set_goal) {
            _e setgoal(_e.origin);
          }
        }
      }
    }
  }

  function _cleanup() {
    if(isDefined(_e) && isDefined(_e.current_scene)) {
      _e flagsys::clear(_o_bundle._str_name);
      if(_e.current_scene == _o_bundle._str_name) {
        _e flagsys::clear("scene");
        _e.finished_scene = _o_bundle._str_name;
        _e.current_scene = undefined;
        _e._o_scene = undefined;
        if(is_player()) {
          if(!(isDefined(_s.newplayermethod) && _s.newplayermethod)) {
            _e delete();
            thread reset_player();
          }
          _e.animname = undefined;
        }
      }
    }
    self notify("death");
    self endon("new_state");
    waittillframeend();
    self notify("cleanup");
    if(isai(_e)) {
      _set_goal();
    }
    if(isDefined(_o_bundle) && (isDefined(_o_bundle.scene_stopping) && _o_bundle.scene_stopping)) {
      _o_bundle = undefined;
    }
  }

  function do_death_anims() {
    ent = _e;
    if(isai(ent) && !isDefined(_str_death_anim) && !isDefined(_str_death_anim_loop)) {
      ent stopanimscripted();
      if(isactor(ent)) {
        ent startragdoll();
      }
    }
    if(isDefined(_str_death_anim)) {
      ent.skipdeath = 1;
      ent animation::play(_str_death_anim, ent, undefined, 1, 0.2, 0);
    }
    if(isDefined(_str_death_anim_loop)) {
      ent.skipdeath = 1;
      ent animation::play(_str_death_anim_loop, ent, undefined, 1, 0, 0);
    }
  }

  function _on_death() {
    self endon("cleanup");
    _e waittill("death");
    if(isDefined(_e) && (!(isDefined(_e.skipscenedeath) && _e.skipscenedeath))) {
      self thread do_death_anims();
    }
  }

  function set_objective() {
    if(!isDefined(_e.script_objective)) {
      if(isDefined(_o_bundle._e_root.script_objective)) {
        _e.script_objective = _o_bundle._e_root.script_objective;
      } else if(isDefined(_o_bundle._s.script_objective)) {
        _e.script_objective = _o_bundle._s.script_objective;
      }
    }
  }

  function _finish_player(player) {
    if(getdvarint("") > 0) {
      printtoprightln("");
    }
    player.scene_set_visible_time = level.time;
    player setvisibletoall();
    player flagsys::clear("shared_igc");
    if(!(isDefined(player.magic_bullet_shield) && player.magic_bullet_shield)) {
      player.allowdeath = 1;
    }
    player.current_player_scene = undefined;
    player.scene_takedamage = undefined;
    player._scene_old_gun_removed = undefined;
    player thread scene::scene_enable_player_stuff(!(isDefined(_s.showhud) && _s.showhud));
    if(![
        [_o_bundle]
      ] - > has_next_scene()) {
      if([[_o_bundle]] - > is_player_anim_ending_early()) {
        if(!([
            [_o_bundle]
          ] - > is_skipping_scene()) && [
            [_o_bundle]
          ] - > is_scene_shared_sequence()) {
          [
            [_o_bundle]
          ] - > init_scene_sequence_started(0);
        }
        _o_bundle thread cscene::_stop_camera_anim_on_player(player);
      } else if(_o_bundle._s scene::is_igc()) {
        _o_bundle thread cscene::_stop_camera_anim_on_player(player);
      }
    }
    n_camera_tween_out = get_camera_tween_out();
    if(n_camera_tween_out > 0) {
      player startcameratween(n_camera_tween_out);
    }
    if(!(isDefined(_s.dontreloadammo) && _s.dontreloadammo)) {
      player player::fill_current_clip();
    }
    player allowstand(1);
    player allowcrouch(1);
    player allowprone(1);
    player sethighdetail(0);
  }

  function finish(b_clear = 0, b_canceled = 0) {
    if(getdvarint("") > 0) {
      printtoprightln("" + (isDefined(_s.name) ? _s.name : _s.model));
    }
    if(isDefined(_str_state)) {
      _str_state = undefined;
      self notify("new_state");
      if(!is_shared_player() && !is_alive()) {
        _cleanup();
        _e = undefined;
        _is_valid = 0;
      } else {
        if(!is_player()) {
          if(isDefined(_e._scene_old_takedamage)) {
            _e.takedamage = _e._scene_old_takedamage;
          }
          if(!(isDefined(_e.magic_bullet_shield) && _e.magic_bullet_shield)) {
            _e.allowdeath = 1;
          }
          _e._scene_old_takedamage = undefined;
          _e._scene_old_gun_removed = undefined;
        } else {
          if(is_shared_player()) {
            foreach(player in level.players) {
              if(player flagsys::get("shared_igc")) {
                _finish_player(player);
              }
            }
          } else {
            player = (isplayer(_player) ? _player : _e);
            _finish_player(player);
          }
        }
        if(isDefined(_s.removeweapon) && _s.removeweapon && (!(isDefined(_e._scene_old_gun_removed) && _e._scene_old_gun_removed))) {
          if(isplayer(_e)) {
            if(getdvarint("") > 0) {
              printtoprightln("" + (isDefined(_s.name) ? _s.name : _s.model));
            }
            _e player::give_back_weapons();
          } else {
            printtoprightln("" + (isDefined(_s.name) ? _s.name : _s.model));
            if(getdvarint("") > 0) {}
            _e animation::attach_weapon();
          }
        }
        if(!isplayer(_e)) {
          if(isDefined(_e)) {
            _e sethighdetail(0);
          }
        }
      }
      flagsys::set("ready");
      flagsys::set("done");
      if(isDefined(_e)) {
        if(!is_player()) {
          if(is_alive() && (isDefined(_s.deletewhenfinished) && _s.deletewhenfinished || b_clear)) {
            _e thread scene::synced_delete();
          } else if(is_alive() && (isDefined(_s.diewhenfinished) && _s.diewhenfinished) && !b_canceled) {
            _e.skipdeath = 1;
            _e.allowdeath = 1;
            _e.skipscenedeath = 1;
            _e kill();
          }
        }
        if(isactor(_e) && isalive(_e)) {
          if(isDefined(_s.delaymovementatend) && _s.delaymovementatend) {
            _e pathmode("move delayed", 1, randomfloatrange(2, 3));
          } else {
            _e pathmode("move allowed");
          }
          if(isDefined(_s.lookatplayer) && _s.lookatplayer) {
            _e lookatentity();
          }
        }
      }
      _cleanup();
    }
  }

  function set_player_stance(player) {
    if(_s.playerstance === "crouch") {
      player allowstand(0);
      player allowcrouch(1);
      player allowprone(0);
    } else {
      if(_s.playerstance === "prone") {
        player allowstand(0);
        player allowcrouch(0);
        player allowprone(1);
      } else {
        player allowstand(1);
        player allowcrouch(0);
        player allowprone(0);
      }
    }
  }

  function revive_player(player) {
    if(player.sessionstate === "spectator") {
      player thread[[level.spawnplayer]]();
    } else if(player laststand::player_is_in_laststand()) {
      player notify("auto_revive");
    }
  }

  function _prepare_player(player) {
    if(getdvarint("") > 0) {
      printtoprightln("");
    }
    if(isDefined(player.play_scene_transition_effect) && player.play_scene_transition_effect) {
      player.play_scene_transition_effect = undefined;
      play_regroup_fx_for_scene(player);
    }
    if(player.current_player_scene === _o_bundle._str_name) {
      [
        [_o_bundle]
      ] - > trigger_scene_sequence_started(self, player);
      return false;
    }
    player sethighdetail(1);
    if(player flagsys::get("mobile_armory_in_use")) {
      player flagsys::set("cancel_mobile_armory");
      player closemenu("ChooseClass_InGame");
      player notify("menuresponse", "ChooseClass_InGame", "cancel");
    }
    if(player flagsys::get("mobile_armory_begin_use")) {
      player util::_enableweapon();
      player flagsys::clear("mobile_armory_begin_use");
    }
    if(getdvarint("scene_hide_player") > 0) {
      player hide();
    }
    player.current_player_scene = _o_bundle._str_name;
    if(!(isDefined(player.magic_bullet_shield) && player.magic_bullet_shield)) {
      player.allowdeath = isDefined(_s.allowdeath) && _s.allowdeath;
    }
    player.scene_takedamage = isDefined(_s.takedamage) && _s.takedamage;
    if(isDefined(player.hijacked_vehicle_entity)) {
      player.hijacked_vehicle_entity delete();
    } else if(player isinvehicle()) {
      vh_occupied = player getvehicleoccupied();
      n_seat = vh_occupied getoccupantseat(player);
      vh_occupied usevehicle(player, n_seat);
    }
    revive_player(player);
    player thread scene::scene_disable_player_stuff(!(isDefined(_s.showhud) && _s.showhud));
    player.player_anim_look_enabled = !(isDefined(_s.lockview) && _s.lockview);
    player.player_anim_clamp_right = (isDefined(_s.viewclampright) ? _s.viewclampright : 0);
    player.player_anim_clamp_left = (isDefined(_s.viewclampleft) ? _s.viewclampleft : 0);
    player.player_anim_clamp_top = (isDefined(_s.viewclampbottom) ? _s.viewclampbottom : 0);
    player.player_anim_clamp_bottom = (isDefined(_s.viewclampbottom) ? _s.viewclampbottom : 0);
    if(!(isDefined(_s.removeweapon) && _s.removeweapon) || (isDefined(_s.showweaponinfirstperson) && _s.showweaponinfirstperson) && (!(isDefined(_s.disableprimaryweaponswitch) && _s.disableprimaryweaponswitch))) {
      player player::switch_to_primary_weapon(1);
    }
    set_player_stance(player);
  }

  function _prepare() {
    if(isDefined(_s.dynamicpaths) && _s.dynamicpaths && _str_state == "play") {
      _e.scene_orig_origin = _e.origin;
      _e connectpaths();
    }
    if(_e.current_scene === _o_bundle._str_name) {
      [
        [_o_bundle]
      ] - > trigger_scene_sequence_started(self, _e);
      return false;
    }
    _e endon("death");
    if(!(isDefined(_s.ignorealivecheck) && _s.ignorealivecheck) && (cscriptbundleobjectbase::error(isai(_e) && !isalive(_e), "Trying to play a scene on a dead AI."))) {
      return;
    }
    if(isDefined(_e._o_scene)) {
      foreach(obj in _e._o_scene._a_objects) {
        if(obj._e === _e) {
          [
            [obj]
          ] - > finish();
          break;
        }
      }
    }
    if(!isai(_e) && !isplayer(_e)) {
      if(!is_player() || (!(isDefined(_s.newplayermethod) && _s.newplayermethod))) {
        if(is_player_model()) {
          scene::prepare_player_model_anim(_e);
        } else {
          scene::prepare_generic_model_anim(_e);
        }
      }
    }
    if(!is_player()) {
      if(!isDefined(_e._scene_old_takedamage)) {
        _e._scene_old_takedamage = _e.takedamage;
      }
      if(issentient(_e)) {
        _e.takedamage = isDefined(_e.takedamage) && _e.takedamage && (isDefined(_s.takedamage) && _s.takedamage);
        if(!(isDefined(_e.magic_bullet_shield) && _e.magic_bullet_shield)) {
          _e.allowdeath = isDefined(_s.allowdeath) && _s.allowdeath;
        }
        if(isDefined(_s.overrideaicharacter) && _s.overrideaicharacter) {
          _e detachall();
          _e setModel(_s.model);
        }
      } else {
        _e.health = (_e.health > 0 ? _e.health : 1);
        if(_s.type === "actor") {
          _e makefakeai();
          if(!(isDefined(_s.removeweapon) && _s.removeweapon)) {
            _e animation::attach_weapon(getweapon("ar_standard"));
          }
        }
        _e.takedamage = isDefined(_s.takedamage) && _s.takedamage;
        _e.allowdeath = isDefined(_s.allowdeath) && _s.allowdeath;
      }
      set_objective();
      if(isDefined(_s.dynamicpaths) && _s.dynamicpaths) {
        _e disconnectpaths(2, 0);
      }
    } else if(!is_shared_player()) {
      player = (isplayer(_player) ? _player : _e);
      _prepare_player(player);
    }
    if(isDefined(_s.removeweapon) && _s.removeweapon) {
      if(!(isDefined(_e.gun_removed) && _e.gun_removed)) {
        if(isplayer(_e)) {
          _e player::take_weapons();
        } else {
          _e animation::detach_weapon();
        }
      } else {
        _e._scene_old_gun_removed = 1;
      }
    }
    _e.animname = _str_name;
    _e.anim_debug_name = _s.name;
    _e flagsys::set("scene");
    _e flagsys::set(_o_bundle._str_name);
    _e.current_scene = _o_bundle._str_name;
    _e.finished_scene = undefined;
    _e._o_scene = scene();
    [[_o_bundle]] - > trigger_scene_sequence_started(self, _e);
    if(isDefined(_e.takedamage) && _e.takedamage) {
      thread _on_damage_run_scene_thread();
      thread _on_death();
    }
    if(isactor(_e)) {
      thread _track_goal();
      if(isDefined(_s.lookatplayer) && _s.lookatplayer) {
        _e lookatentity(level.activeplayers[0]);
      }
    }
    if(_o_bundle._s scene::is_igc() || [
        [_o_bundle]
      ] - > has_player()) {
      if(!isplayer(_e)) {
        _e sethighdetail(1);
      }
    }
    return true;
  }

  function _spawn(e_spawner, b_hide = 1, b_set_ready_when_spawned = 1) {
    if(isDefined(e_spawner)) {
      _e = e_spawner;
    }
    if(isDefined(_e) && (isDefined(_e.isdying) && _e.isdying)) {
      _e delete();
    }
    if(is_player()) {
      if(isplayer(_e)) {
        _player = _e;
      } else {
        n_player = getdvarint("scene_debug_player", 0);
        if(n_player > 0) {
          n_player--;
          if(n_player == _s.player) {
            _player = level.activeplayers[0];
          }
        } else {
          _player = level.activeplayers[_s.player];
        }
      }
    }
    b_skip = _s.type === "actor" && issubstr(_o_bundle._str_mode, "noai");
    b_skip = b_skip || (_s.type === "player" && issubstr(_o_bundle._str_mode, "noplayers"));
    if(!b_skip && _should_skip_entity()) {
      b_skip = 1;
    }
    if(!b_skip) {
      if(!isDefined(_e) && is_player() && (isDefined(_s.newplayermethod) && _s.newplayermethod)) {
        _e = _player;
      } else if(!isDefined(_e) || isspawner(_e)) {
        b_allows_multiple = [[scene()]] - > allows_multiple();
        if(cscriptbundleobjectbase::error(b_allows_multiple && (isDefined(_s.nospawn) && _s.nospawn), "Scene that allow multiple instances must be allowed to spawn (uncheck 'Do Not Spawn').")) {
          return;
        }
        if(!isspawner(_e)) {
          e = scene::get_existing_ent(_str_name, b_allows_multiple);
          if(!isDefined(e) && isDefined(_s.name)) {
            e = scene::get_existing_ent(_s.name, b_allows_multiple);
          }
          if(isplayer(e)) {
            if(!(isDefined(_s.newplayermethod) && _s.newplayermethod)) {
              e = undefined;
            }
          }
          if(!isDefined(e) || isspawner(e) && (!(isDefined(_s.nospawn) && _s.nospawn) && !_b_spawnonce_used || _o_bundle._testing)) {
            e_spawned = spawn_ent(e);
          }
        } else {
          e_spawned = spawn_ent(_e);
        }
        if(isDefined(e_spawned)) {
          if(b_hide && !_o_bundle._s scene::is_igc()) {
            e_spawned hide();
          }
          e_spawned dontinterpolate();
          e_spawned.scene_spawned = _o_bundle._s.name;
          if(!isDefined(e_spawned.targetname)) {
            e_spawned.targetname = _s.name;
          }
          if(is_player()) {
            e_spawned hide();
          }
        }
        _e = (isDefined(e_spawned) ? e_spawned : e);
        if(isDefined(_s.spawnonce) && _s.spawnonce && _b_spawnonce_used) {
          return;
        }
      }
      cscriptbundleobjectbase::error(!is_player() && (!(isDefined(_s.nospawn) && _s.nospawn)) && (!isDefined(_e) || isspawner(_e)), "Object failed to spawn or doesn't exist.");
    }
    if(isDefined(_e) && !isspawner(_e)) {
      [
        [self]
      ] - > _prepare();
      if(b_set_ready_when_spawned) {
        flagsys::set("ready");
      }
      if(isDefined(_s.spawnonce) && _s.spawnonce) {
        _b_spawnonce_used = 1;
      }
    } else {
      flagsys::set("ready");
      flagsys::set("done");
      finish();
    }
  }

  function get_orig_name() {
    return _s.name;
  }

  function get_name() {
    return _str_name;
  }

  function _assign_unique_name() {
    if(is_player()) {
      _str_name = "player " + _s.player;
    } else {
      if([[scene()]] - > allows_multiple()) {
        if(isDefined(_s.name)) {
          _str_name = (_s.name + "_gen") + level.scene_object_id;
        } else {
          _str_name = (([
            [scene()]
          ] - > get_name()) + "_noname") + level.scene_object_id;
        }
        level.scene_object_id++;
      } else {
        if(isDefined(_s.name)) {
          _str_name = _s.name;
        } else {
          _str_name = (([
            [scene()]
          ] - > get_name()) + "_noname") + ([
            [scene()]
          ] - > get_object_id());
        }
      }
    }
  }

  function _on_damage_run_scene_thread() {
    self endon("play");
    self endon("done");
    loc_00001C10:
      loc_00001C60:
      loc_00001CB0:
      loc_00001D00:
      str_damage_types = (!isDefined(_s.runsceneondmg0) || (_s.runsceneondmg0 == "none" ? "" : _s.runsceneondmg0)) + (!isDefined(_s.runsceneondmg1) || (_s.runsceneondmg1 == "none" ? "" : _s.runsceneondmg1)) + (!isDefined(_s.runsceneondmg2) || (_s.runsceneondmg2 == "none" ? "" : _s.runsceneondmg2)) + (!isDefined(_s.runsceneondmg3) || (_s.runsceneondmg3 == "none" ? "" : _s.runsceneondmg3)) + (!isDefined(_s.runsceneondmg4) || (_s.runsceneondmg4 == "none" ? "" : _s.runsceneondmg4));
    if(str_damage_types != "") {
      b_run_scene = 0;
      while(!b_run_scene) {
        _e waittill("damage", n_amount, e_attacker, v_org, v_dir, str_mod);
        switch (str_mod) {
          case "MOD_PISTOL_BULLET":
          case "MOD_RIFLE_BULLET": {
            if(issubstr(str_damage_types, "bullet")) {
              b_run_scene = 1;
            }
            break;
          }
          case "MOD_EXPLOSIVE":
          case "MOD_GRENADE":
          case "MOD_GRENADE_SPLASH": {
            if(issubstr(str_damage_types, "explosive")) {
              b_run_scene = 1;
            }
            break;
          }
          case "MOD_PROJECTILE":
          case "MOD_PROJECTILE_SPLASH": {
            if(issubstr(str_damage_types, "projectile")) {
              b_run_scene = 1;
            }
            break;
          }
          case "MOD_MELEE": {
            if(issubstr(str_damage_types, "melee")) {
              b_run_scene = 1;
            }
            break;
          }
          default: {
            if(issubstr(str_damage_types, "all")) {
              b_run_scene = 1;
            }
          }
        }
      }
      thread[[scene()]] - > play();
    }
  }

  function scene() {
    return _o_bundle;
  }

  function get_align_tag() {
    if(isDefined(_s.aligntargettag)) {
      return _s.aligntargettag;
    }
    if(isDefined(_o_bundle._e_root.e_scene_link)) {
      return "tag_origin";
    }
    return _o_bundle._s.aligntargettag;
  }

  function get_align_ent() {
    e_align = undefined;
    if(isDefined(_s.aligntarget) && !_s.aligntarget === _o_bundle._s.aligntarget) {
      a_scene_ents = [
        [_o_bundle]
      ] - > get_ents();
      if(isDefined(a_scene_ents[_s.aligntarget])) {
        e_align = a_scene_ents[_s.aligntarget];
      } else {
        e_align = scene::get_existing_ent(_s.aligntarget, 0, 1);
      }
      if(!isDefined(e_align)) {
        str_msg = ("Align target '" + (isDefined(_s.aligntarget) ? "" + _s.aligntarget : "")) + "' doesn't exist for scene object.";
        if(!cscriptbundleobjectbase::warning(_o_bundle._testing, str_msg)) {
          cscriptbundleobjectbase::error(getdvarint("scene_align_errors", 1), str_msg);
        }
      }
    }
    if(!isDefined(e_align)) {
      e_align = [
        [scene()]
      ] - > get_align_ent();
    }
    return e_align;
  }

  function stop(b_clear = 0, b_dont_clear_anim = 0, b_finished = 0) {
    if(getdvarint("") > 0) {
      printtoprightln("" + (isDefined(_s.name) ? _s.name : _s.model));
    }
    if(isalive(_e)) {
      if(is_shared_player()) {
        foreach(player in level.players) {
          player stopanimscripted(0.2);
        }
      } else if(!(isDefined(_s.diewhenfinished) && _s.diewhenfinished) || !b_finished) {
        if(!b_dont_clear_anim || isplayer(_e)) {
          _e stopanimscripted(0.2);
        }
      }
    }
    finish(b_clear, !b_finished);
  }

  function play() {
    if(getdvarint("") > 0) {
      if(isDefined(_s.name)) {
        printtoprightln("" + _s.name);
      } else {
        printtoprightln("" + _s.model);
      }
    }
    flagsys::clear("ready");
    flagsys::clear("done");
    flagsys::clear("main_done");
    _str_state = "play";
    self notify("new_state");
    self endon("new_state");
    self notify("play");
    cscriptbundleobjectbase::log("play");
    waittillframeend();
    if(isDefined(_s.hide) && _s.hide && _is_valid) {
      _spawn(undefined, 0, 0);
      _e hide();
    } else if(isDefined(_s.mainanim) && _is_valid) {
      _str_death_anim = _s.mainanimdeath;
      _str_death_anim_loop = _s.mainanimdeathloop;
      if(!(isDefined(_s.iscutscene) && _s.iscutscene)) {
        if(!isDefined(_s.mainblend) || _s.mainblend == 0) {
          _s.mainblend = 0.2;
        } else if(_s.mainblend == 0.001) {
          _s.mainblend = 0;
        }
      }
      _play_anim(_s.mainanim, _s.maindelaymin, _s.maindelaymax, 1, _s.mainblend, _o_bundle.n_start_time);
      flagsys::set("main_done");
      if(isDefined(_e) && (isDefined(_s.dynamicpaths) && _s.dynamicpaths)) {
        if(distance2dsquared(_e.origin, _e.scene_orig_origin) > 4) {
          _e disconnectpaths(2, 0);
        }
      }
      if(is_alive()) {
        if(!isDefined(_s.endblend) || _s.endblend == 0) {
          _s.endblend = 0.2;
        }
        if(isDefined(_s.endanim)) {
          _str_death_anim = _s.endanimdeath;
          _str_death_anim_loop = _s.endanimdeathloop;
          _play_anim(_s.endanim, 0, 0, 1, _s.endblend);
          if(is_alive()) {
            if(isDefined(_s.endanimloop)) {
              _str_death_anim = _s.endanimloopdeath;
              _str_death_anim_loop = _s.endanimloopdeathloop;
              _play_anim(_s.endanimloop, 0, 0, 1);
            }
          }
        } else if(isDefined(_s.endanimloop)) {
          _str_death_anim = _s.endanimloopdeath;
          _str_death_anim_loop = _s.endanimloopdeathloop;
          _play_anim(_s.endanimloop, 0, 0, 1);
        }
      }
    }
    thread finish();
  }

  function initialize(b_force_first_frame = 0) {
    if(has_init_state() || b_force_first_frame) {
      flagsys::clear("ready");
      flagsys::clear("done");
      flagsys::clear("main_done");
      _str_state = "init";
      self notify("new_state");
      self endon("new_state");
      self notify("init");
      cscriptbundleobjectbase::log("init");
      waittillframeend();
      if(!(isDefined(_s.sharedigc) && _s.sharedigc) && (!(isDefined(_s.player) && _s.player)) && (isDefined(_s.spawnoninit) && _s.spawnoninit) || b_force_first_frame) {
        _spawn(undefined, isDefined(_s.firstframe) && _s.firstframe || isDefined(_s.initanim) || isDefined(_s.initanimloop));
      }
      if(isDefined(_s.firstframe) && _s.firstframe || b_force_first_frame) {
        if(!cscriptbundleobjectbase::error(!isDefined(_s.mainanim), "No animation defined for first frame.")) {
          _str_death_anim = _s.mainanimdeath;
          _str_death_anim_loop = _s.mainanimdeathloop;
          _play_anim(_s.mainanim, 0, 0, 0);
        }
      } else {
        if(isDefined(_s.initanim)) {
          _str_death_anim = _s.initanimdeath;
          _str_death_anim_loop = _s.initanimdeathloop;
          _play_anim(_s.initanim, _s.initdelaymin, _s.initdelaymax, 1);
          if(is_alive()) {
            if(isDefined(_s.initanimloop)) {
              _str_death_anim = _s.initanimloopdeath;
              _str_death_anim_loop = _s.initanimloopdeathloop;
              _play_anim(_s.initanimloop, 0, 0, 1);
            }
          }
        } else if(isDefined(_s.initanimloop)) {
          _str_death_anim = _s.initanimloopdeath;
          _str_death_anim_loop = _s.initanimloopdeathloop;
          _play_anim(_s.initanimloop, _s.initdelaymin, _s.initdelaymax, 1);
        }
      }
    } else {
      flagsys::set("ready");
    }
    if(!_is_valid) {
      flagsys::set("done");
    }
  }

  function first_init(s_objdef, o_scene, e_ent) {
    cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent);
    _assign_unique_name();
    return self;
  }

}

class cscene: cscriptbundlebase {
  var _a_objects;
  var _s;
  var _str_state;
  var scene_stopped;
  var skipping_scene;
  var _n_request_time;
  var _n_streamer_req;
  var _e_root;
  var _testing;
  var _str_notify_name;
  var _str_mode;
  var _str_name;
  var scene_stopping;
  var b_player_scene;
  var played_camera_anims;
  var a_xcam_players;
  var camera_start_time;
  var camera_v_angles;
  var camera_v_origin;
  var n_start_time;
  var longest_anim_length;
  var _n_object_id;

  constructor() {
    _n_object_id = 0;
    _str_mode = "";
    _n_streamer_req = -1;
  }

  destructor() {}

  function has_player() {
    foreach(obj in _a_objects) {
      if(obj._s.type === "player") {
        return true;
      }
    }
    return false;
  }

  function private trigger_scene_sequence_started(scene_object, entity) {
    if(self === scene_object) {
      if(!is_skipping_scene()) {
        init_scene_sequence_started(1);
      }
      return;
    }
    if(isplayer(entity)) {
      if(!(isDefined(_s.disablesceneskipping) && _s.disablesceneskipping) && !is_skipping_scene()) {
        if([
            [scene_object]
          ] - > is_shared_player() || _s scene::is_igc()) {
          if(_str_state != "init" || (isDefined(scene_object._s.initanim) || isDefined(scene_object._s.initanimloop))) {
            init_scene_sequence_started(1);
          }
        }
      }
    }
  }

  function private init_scene_sequence_started(b_started) {
    if(isDefined(b_started) && b_started) {
      scene::waittill_skip_sequence_completed();
      if(isDefined(level.shared_scene_sequence_started)) {
        return;
      }
      _s.shared_scene_sequence = 1;
      if(isDefined(_s.s_female_bundle)) {
        _s.s_female_bundle.shared_scene_sequence = _s.shared_scene_sequence;
      }
      if(isstring(_s.nextscenebundle)) {
        s_cur_bundle = scene::get_scenedef(_s.nextscenebundle);
        while(true) {
          s_cur_bundle.shared_scene_sequence = _s.shared_scene_sequence;
          if(isDefined(s_cur_bundle.s_female_bundle)) {
            s_cur_bundle.s_female_bundle.shared_scene_sequence = _s.shared_scene_sequence;
          }
          if(isstring(s_cur_bundle.nextscenebundle)) {
            s_cur_bundle = scene::get_scenedef(s_cur_bundle.nextscenebundle);
          } else {
            break;
          }
        }
      }
      level.shared_scene_sequence_started = 1;
      update_scene_sequence();
      level notify("scene_sequence_started");
    } else {
      if(!isDefined(level.shared_scene_sequence_started)) {
        return;
      }
      if(isDefined(_s.shared_scene_sequence)) {
        level.shared_scene_sequence_started = undefined;
        update_scene_sequence();
        level notify("scene_sequence_ended", _s.name);
      }
    }
  }

  function private update_scene_sequence() {
    if(isDefined(_s.shared_scene_sequence)) {
      if(isDefined(level.shared_scene_sequence_started)) {
        level.shared_scene_sequence_name = _s.name;
      } else {
        level.shared_scene_sequence_name = undefined;
      }
    }
  }

  function private is_scene_shared_sequence() {
    return isDefined(level.shared_scene_sequence_started) && isDefined(_s.shared_scene_sequence);
  }

  function should_skip_linked_to_players_scene() {
    if(isDefined(level.player_skipping_scene) && (!(isDefined(_s.disablesceneskipping) && _s.disablesceneskipping)) && array::contains(level.linked_scenes, _s.name)) {
      return true;
    }
    return false;
  }

  function private _skip_scene() {
    self endon("stopped");
    wait(0.05);
    foreach(o_scene_object in _a_objects) {
      if(o_scene_object._is_valid) {
        [[o_scene_object]] - > skip_scene_on_client();
      }
    }
    wait(0.05);
    foreach(o_scene_object in _a_objects) {
      if(o_scene_object._is_valid) {
        [[o_scene_object]] - > skip_scene_on_server();
      }
    }
    self notify("skip_camera_anims");
  }

  function private finish_skip_scene() {
    if(getdvarint("") > 0) {
      printtoprightln("" + gettime(), (1, 0, 0));
    }
    if(isDefined(level.player_skipping_scene)) {
      foreach(player in level.players) {
        player clientfield::increment_to_player("player_scene_skip_completed");
        player freezecontrols(0);
        player stopsounds();
      }
      self.b_player_scene = undefined;
      self.skipping_scene = undefined;
      level.player_skipping_scene = undefined;
      level.linked_scenes = undefined;
      init_scene_sequence_started(0);
      level notify("scene_skip_sequence_ended");
      if(isDefined(level.bzm_sceneseqendedcallback)) {
        level thread[[level.bzm_sceneseqendedcallback]](_s.name);
      }
      if(getdvarint("") > 0) {
        printtoprightln("" + gettime());
      }
      if(getdvarint("") == 0) {
        b_skip_fading = 0;
      } else {
        b_skip_fading = 1;
      }
      if(!(isDefined(b_skip_fading) && b_skip_fading)) {
        if(!(isDefined(level.level_ending) && level.level_ending)) {
          level thread lui::screen_fade(1, 0, 1, "black", 0, "scene_system");
        }
      }
    }
  }

  function skip_scene(b_sequence) {
    if(isDefined(b_sequence) && b_sequence && (isDefined(_s.disablesceneskipping) && _s.disablesceneskipping)) {
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.name) + "") + gettime(), (1, 0, 0));
      }
      finish_skip_scene();
      return;
    }
    if(getdvarint("") > 0) {
      printtoprightln((("" + _s.name) + "") + gettime(), (0, 1, 0));
    }
    if(!(isDefined(b_sequence) && b_sequence)) {
      if(_str_state == "init") {
        while(_str_state == "init") {
          wait(0.05);
        }
      }
      if(is_skipping_player_scene()) {
        if(getdvarint("") > 0) {
          printtoprightln("" + gettime());
        }
        if(getdvarint("") == 0) {
          b_skip_fading = 0;
        } else {
          b_skip_fading = 1;
        }
        if(!(isDefined(b_skip_fading) && b_skip_fading)) {
          foreach(player in level.players) {
            player freezecontrols(1);
          }
          level.suspend_scene_skip_until_fade = 1;
          level thread lui::screen_fade(1, 1, 0, "black", 0, "scene_system");
          wait(1);
          level.suspend_scene_skip_until_fade = undefined;
        }
        setpauseworld(0);
      }
      while(isDefined(level.suspend_scene_skip_until_fade) && level.suspend_scene_skip_until_fade) {
        wait(0.05);
      }
    }
    if(isDefined(_s.nextscenebundle)) {
      bnextsceneexist = 1;
    } else {
      bnextsceneexist = 0;
    }
    wait_till_scene_ready();
    wait(0.05);
    if(getdvarint("") > 0) {
      printtoprightln((("" + _s.name) + "") + gettime(), (0, 0, 1));
    }
    _call_state_funcs("skip_started");
    thread _skip_scene();
    if(getdvarint("") > 0) {
      printtoprightln("" + gettime(), (0, 1, 0));
    }
    if(getdvarint("") > 0) {
      if(isDefined(level.animation_played)) {
        for(i = 0; i < level.animation_played.size; i++) {
          printtoprightln("" + level.animation_played[i], (1, 0, 0), -1);
        }
      }
    }
    scene_skip_timeout = gettime() + 4000;
    while(!(isDefined(scene_stopped) && scene_stopped) && gettime() < scene_skip_timeout) {
      wait(0.05);
    }
    if(getdvarint("") > 0) {
      printtoprightln((("" + _s.name) + "") + gettime(), (1, 0.5, 0));
    }
    _call_state_funcs("skip_completed");
    self notify("scene_skip_completed");
    if(!bnextsceneexist) {
      if(is_skipping_player_scene()) {
        if(isDefined(level.linked_scenes)) {
          linked_scenes_timeout = gettime() + 4000;
          while(level.linked_scenes.size > 0 && gettime() < linked_scenes_timeout) {
            wait(0.05);
          }
        }
        finish_skip_scene();
      } else if(isDefined(skipping_scene) && skipping_scene) {
        self.skipping_scene = undefined;
        if(isDefined(level.linked_scenes)) {
          arrayremovevalue(level.linked_scenes, _s.name);
        }
      }
    } else if(is_skipping_player_scene()) {
      if(_s scene::is_igc()) {
        foreach(player in level.players) {
          player stopsounds();
        }
      }
    }
  }

  function is_scene_shared() {
    if(!(isDefined(_s.skip_scene) && _s.skip_scene) && !_s scene::is_igc()) {
      foreach(o_scene_object in _a_objects) {
        if(o_scene_object._is_valid && [
            [o_scene_object]
          ] - > is_shared_player()) {
          b_shared_player = 1;
        }
      }
      if(!isDefined(b_shared_player)) {
        if(getdvarint("") > 0) {
          printtoprightln("" + gettime(), (1, 0, 0));
        }
        self notify("scene_skip_completed");
        return false;
      }
    }
    return true;
  }

  function get_state() {
    return _str_state;
  }

  function on_error() {
    stop();
  }

  function get_valid_objects() {
    a_obj = [];
    foreach(obj in _a_objects) {
      if(obj._is_valid) {
        if(!isDefined(a_obj)) {
          a_obj = [];
        } else if(!isarray(a_obj)) {
          a_obj = array(a_obj);
        }
        a_obj[a_obj.size] = obj;
      }
    }
    return a_obj;
  }

  function sync_with_other_scenes() {
    if(!(isDefined(_s.dontsync) && _s.dontsync) && isDefined(level.scene_sync_list) && isarray(level.scene_sync_list[_n_request_time])) {
      wait_till_objects_ready(level.scene_sync_list[_n_request_time]);
    }
  }

  function wait_till_objects_ready(&array) {
    do {
      recheck = 0;
      foreach(ent in array) {
        if(isDefined(ent) && !ent flagsys::get("ready")) {
          ent util::waittill_either("death", "ready");
          recheck = 1;
          break;
        }
      }
    }
    while(recheck);
  }

  function wait_till_scene_ready(o_exclude, b_ignore_streamer = 0) {
    a_objects = [];
    if(isDefined(o_exclude)) {
      a_objects = array::exclude(_a_objects, o_exclude);
    } else {
      a_objects = _a_objects;
    }
    wait_till_objects_ready(a_objects);
    if(_n_streamer_req != -1) {
      if(!b_ignore_streamer) {
        if(isDefined(level.wait_for_streamer_hint_scenes)) {
          if(isinarray(level.wait_for_streamer_hint_scenes, _s.name)) {
            if(!is_skipping_scene()) {
              level util::streamer_wait(_n_streamer_req, 0, 5);
            }
          }
        }
      }
    }
    flagsys::set("ready");
    sync_with_other_scenes();
  }

  function is_looping() {
    return isDefined(_s.looping) && _s.looping;
  }

  function allows_multiple() {
    return isDefined(_s.allowmultiple) && _s.allowmultiple;
  }

  function get_align_ent() {
    e_align = _e_root;
    if(isDefined(_s.aligntarget)) {
      e_gdt_align = scene::get_existing_ent(_s.aligntarget, 0, 1);
      if(isDefined(e_gdt_align)) {
        e_align = e_gdt_align;
      }
      if(!isDefined(e_gdt_align)) {
        str_msg = ("Align target '" + (isDefined(_s.aligntarget) ? "" + _s.aligntarget : "")) + "' doesn't exist for scene.";
        if(!cscriptbundlebase::warning(_testing, str_msg)) {
          cscriptbundlebase::error(getdvarint("scene_align_errors", 1), str_msg);
        }
      }
    } else if(isDefined(_e_root.e_scene_link)) {
      e_align = _e_root.e_scene_link;
    }
    return e_align;
  }

  function get_root() {
    return _e_root;
  }

  function get_ents() {
    a_ents = [];
    foreach(o_obj in _a_objects) {
      ent = [
        [o_obj]
      ] - > get_ent();
      if(isDefined(o_obj._s.name)) {
        a_ents[o_obj._s.name] = ent;
        continue;
      }
      if(!isDefined(a_ents)) {
        a_ents = [];
      } else if(!isarray(a_ents)) {
        a_ents = array(a_ents);
      }
      a_ents[a_ents.size] = ent;
    }
    return a_ents;
  }

  function _call_state_funcs(str_state) {
    self endon("stopped");
    wait_till_scene_ready(undefined, 1);
    if(str_state == "play") {
      waittillframeend();
    }
    level notify((_str_notify_name + "_") + str_state);
    if(isDefined(level.scene_funcs) && isDefined(level.scene_funcs[_str_notify_name]) && isDefined(level.scene_funcs[_str_notify_name][str_state])) {
      a_ents = get_ents();
      foreach(handler in level.scene_funcs[_str_notify_name][str_state]) {
        func = handler[0];
        args = handler[1];
        switch (args.size) {
          case 6: {
            _e_root thread[[func]](a_ents, args[0], args[1], args[2], args[3], args[4], args[5]);
            break;
          }
          case 5: {
            _e_root thread[[func]](a_ents, args[0], args[1], args[2], args[3], args[4]);
            break;
          }
          case 4: {
            _e_root thread[[func]](a_ents, args[0], args[1], args[2], args[3]);
            break;
          }
          case 3: {
            _e_root thread[[func]](a_ents, args[0], args[1], args[2]);
            break;
          }
          case 2: {
            _e_root thread[[func]](a_ents, args[0], args[1]);
            break;
          }
          case 1: {
            _e_root thread[[func]](a_ents, args[0]);
            break;
          }
          case 0: {
            _e_root thread[[func]](a_ents);
            break;
          }
          default: {
            assertmsg("");
          }
        }
      }
    }
  }

  function has_init_state() {
    b_has_init_state = 0;
    foreach(o_scene_object in _a_objects) {
      if([[o_scene_object]] - > has_init_state()) {
        b_has_init_state = 1;
        break;
      }
    }
    return b_has_init_state;
  }

  function _release_object() {
    wait(0.05);
    foreach(o_obj in _a_objects) {
      o_obj._o_bundle = undefined;
    }
  }

  function stop(b_clear = 0, b_finished = 0) {
    if(getdvarint("") > 0) {
      printtoprightln("" + _s.name);
    }
    if(isDefined(_str_state)) {
      if(getdvarint("") > 0) {
        printtoprightln((("" + _s.name) + "") + _str_state);
      }
      if(strstartswith(_str_mode, "")) {
        adddebugcommand("");
      }
      if(!b_finished) {
        streamer_request_completed();
      }
      if(!is_skipping_scene()) {
        if(!isDefined(_s.nextscenebundle) && is_scene_shared_sequence()) {
          init_scene_sequence_started(0);
        }
      }
      self thread sync_with_client_scene("stop", b_clear);
      _str_state = undefined;
      self notify("new_state");
      self notify("death");
      level flagsys::clear(_str_name + "_playing");
      level flagsys::clear(_str_name + "_initialized");
      thread _call_state_funcs("stop");
      scene_stopping = 1;
      if(isDefined(_a_objects) && !b_finished) {
        foreach(o_obj in _a_objects) {
          if(isDefined(o_obj) && !([
              [o_obj]
            ] - > in_a_different_scene())) {
            thread[[o_obj]] - > stop(b_clear);
          }
        }
      }
      self thread _stop_camera_anims();
      if(!isDefined(_s.nextscenebundle) || !b_finished) {
        destroy_dev_info();
      }
      if(getdvarint("") > 0) {
        printtoprightln("" + _s.name);
      }
      scene_stopped = 1;
      self notify("stopped", b_finished);
      remove_from_sync_list();
      arrayremovevalue(level.active_scenes[_str_name], _e_root);
      if(level.active_scenes[_str_name].size == 0) {
        level.active_scenes[_str_name] = undefined;
      }
      if(isDefined(_e_root)) {
        arrayremovevalue(_e_root.scenes, self);
        if(_e_root.scenes.size == 0) {
          _e_root.scenes = undefined;
        }
        _e_root notify("scene_done", _str_notify_name);
        _e_root.scene_played = 1;
      }
    }
    if(isDefined(_s.spectateonjoin) && _s.spectateonjoin) {
      level.scene_should_spectate_on_hot_join = undefined;
    }
    self thread _release_object();
  }

  function streamer_request_completed() {
    if(isstring(_s._endstreamerhint)) {
      if(getdvarint("scene_hide_player") > 0) {
        foreach(player in level.players) {
          player show();
        }
      }
      streamerrequest("clear", _s._endstreamerhint);
    }
  }

  function run_next() {
    if(getdvarint("") > 0) {
      printtoprightln("" + gettime());
    }
    b_run_next_scene = 0;
    if(isDefined(_s.nextscenebundle)) {
      self waittill("stopped", b_finished);
      if(b_finished) {
        b_skip_scene = is_skipping_scene();
        if(b_skip_scene) {
          self util::waittill_any_timeout(5, "scene_skip_completed");
          if(getdvarint("") > 0) {
            printtoprightln((("" + _s.nextscenebundle) + "") + gettime(), (1, 1, 0));
          }
        }
        if(getdvarint("") > 0) {
          printtoprightln((("" + _s.nextscenebundle) + "") + gettime(), (1, 0, 0));
        }
        if(_s.scenetype == "fxanim" && _s.nextscenemode === "init") {
          if(!cscriptbundlebase::error(!has_init_state(), ("Scene can't init next scene '" + _s.nextscenebundle) + "' because it doesn't have an init state.")) {
            if(allows_multiple()) {
              _e_root thread scene::init(_s.nextscenebundle, get_ents());
            } else {
              _e_root thread scene::init(_s.nextscenebundle);
            }
          }
        } else {
          if(b_skip_scene) {
            if(is_skipping_player_scene()) {
              _str_mode = "skip_scene_player";
            } else {
              _str_mode = "skip_scene";
            }
          } else {
            b_run_next_scene = 1;
          }
          if(allows_multiple()) {
            _e_root thread scene::play(_s.nextscenebundle, get_ents(), undefined, undefined, undefined, _str_mode);
          } else {
            _e_root thread scene::play(_s.nextscenebundle, undefined, undefined, undefined, undefined, _str_mode);
          }
        }
      }
    }
    if(!(isDefined(b_run_next_scene) && b_run_next_scene)) {
      if(!is_skipping_scene()) {
        if(is_scene_shared_sequence()) {
          init_scene_sequence_started(0);
        }
      } else if(isDefined(level.linked_scenes)) {
        arrayremovevalue(level.linked_scenes, _s.name);
      }
      streamer_request_completed();
    }
  }

  function has_next_scene() {
    return isDefined(_s.nextscenebundle);
  }

  function is_skipping_player_scene() {
    return isDefined(b_player_scene) && b_player_scene || _str_mode == "skip_scene_player" && !array::contains(level.linked_scenes, _s.name);
  }

  function is_skipping_scene() {
    if(_s.name == "cin_ram_02_04_interview_part04") {
      return 0;
    }
    return isDefined(skipping_scene) && skipping_scene || _str_mode == "skip_scene" || _str_mode == "skip_scene_player";
  }

  function destroy_dev_info() {
    if(isDefined(level.hud_scene_dev_info1)) {
      level.hud_scene_dev_info1 destroy();
    }
    if(isDefined(level.hud_scene_dev_info2)) {
      level.hud_scene_dev_info2 destroy();
    }
    if(isDefined(level.hud_scene_dev_info3)) {
      level.hud_scene_dev_info3 destroy();
    }
  }

  function display_dev_info() {
    if(isstring(_s.devstate) && getdvarint("scr_show_shot_info_for_igcs", 0)) {
      if(!isDefined(level.hud_scene_dev_info1)) {
        level.hud_scene_dev_info1 = newhudelem();
        level.hud_scene_dev_info1.alignx = "right";
        level.hud_scene_dev_info1.aligny = "bottom";
        level.hud_scene_dev_info1.horzalign = "user_right";
        level.hud_scene_dev_info1.y = 400;
        level.hud_scene_dev_info1.fontscale = 1.3;
        level.hud_scene_dev_info1.color = (0.4392157, 0.5019608, 0.5647059);
        level.hud_scene_dev_info1 settext("SCENE: " + toupper(_s.name));
      }
      if(!isDefined(level.hud_scene_dev_info2)) {
        level.hud_scene_dev_info2 = newhudelem();
        level.hud_scene_dev_info2.alignx = "right";
        level.hud_scene_dev_info2.aligny = "bottom";
        level.hud_scene_dev_info2.horzalign = "user_right";
        level.hud_scene_dev_info2.y = 420;
        level.hud_scene_dev_info2.fontscale = 1.3;
        level.hud_scene_dev_info2.color = (0.4392157, 0.5019608, 0.5647059);
      }
      level.hud_scene_dev_info2 settext("SHOT: " + toupper(_s.name));
      if(!isDefined(level.hud_scene_dev_info3)) {
        level.hud_scene_dev_info3 = newhudelem();
        level.hud_scene_dev_info3.alignx = "right";
        level.hud_scene_dev_info3.aligny = "bottom";
        level.hud_scene_dev_info3.horzalign = "user_right";
        level.hud_scene_dev_info3.y = 440;
        level.hud_scene_dev_info3.fontscale = 1.3;
        level.hud_scene_dev_info3.color = (0.4392157, 0.5019608, 0.5647059);
        level.hud_scene_dev_info3 settext("STATE: " + toupper(_s.devstate));
      }
    } else {
      destroy_dev_info();
    }
  }

  function _stop_camera_anim_on_player(player) {
    player endon("disconnect");
    if(isstring(_s.cameraswitcher)) {
      player endon("new_camera_switcher");
      player dontinterpolate();
      endcamanimscripted(player);
      player thread scene::scene_enable_player_stuff();
      if(!(isDefined(_s.linkxcamtooneplayer) && _s.linkxcamtooneplayer)) {
        callback::remove_on_loadout(&_play_camera_anim_on_player_callback, self);
      }
    }
    if(isstring(_s.extracamswitcher1)) {
      endextracamanimscripted(player, 0);
    }
    if(isstring(_s.extracamswitcher2)) {
      endextracamanimscripted(player, 1);
    }
    if(isstring(_s.extracamswitcher3)) {
      endextracamanimscripted(player, 2);
    }
    if(isstring(_s.extracamswitcher4)) {
      endextracamanimscripted(player, 3);
    }
  }

  function _stop_camera_anims() {
    if(!(isDefined(played_camera_anims) && played_camera_anims)) {
      return;
    }
    level notify("stop_camera_anims");
    xcam_players = [];
    if(isDefined(a_xcam_players)) {
      xcam_players = a_xcam_players;
    } else {
      xcam_players = getplayers();
    }
    foreach(player in xcam_players) {
      if(isDefined(player)) {
        self thread _stop_camera_anim_on_player(player);
      }
    }
  }

  function _play_extracam_on_player(player, n_index, str_camera_anim, v_origin, v_angles) {
    played_camera_anims = 1;
    extracamanimscripted(player, n_index, str_camera_anim, gettime(), v_origin, v_angles);
  }

  function loop_camera_anim_to_set_up_for_capture() {
    level endon("stop_camera_anims");
    while(true) {
      _play_camera_anims();
      _wait_for_camera_animation(_s.cameraswitcher);
    }
  }

  function _play_camera_anim_on_player(player, v_origin, v_angles, ignore_initial_notetracks) {
    player notify("new_camera_switcher");
    player dontinterpolate();
    player thread scene::scene_disable_player_stuff();
    played_camera_anims = 1;
    n_start_time = camera_start_time;
    if(!isDefined(_s.cameraswitchergraphiccontents) || ismature(player)) {
      camanimscripted(player, _s.cameraswitcher, n_start_time, v_origin, v_angles);
    } else {
      camanimscripted(player, _s.cameraswitchergraphiccontents, n_start_time, v_origin, v_angles);
    }
  }

  function _play_camera_anim_on_player_callback(player) {
    self thread _play_camera_anim_on_player(player, camera_v_origin, camera_v_angles, 1);
  }

  function _play_camera_anims() {
    level endon("stop_camera_anims");
    waittillframeend();
    e_align = get_align_ent();
    v_origin = (isDefined(e_align.origin) ? e_align.origin : (0, 0, 0));
    v_angles = (isDefined(e_align.angles) ? e_align.angles : (0, 0, 0));
    xcam_players = [];
    if(isDefined(_s.linkxcamtooneplayer) && _s.linkxcamtooneplayer) {
      foreach(o_obj in _a_objects) {
        if(isDefined(o_obj) && [
            [o_obj]
          ] - > is_player() && !([
            [o_obj]
          ] - > is_shared_player())) {
          if(!isDefined(xcam_players)) {
            xcam_players = [];
          } else if(!isarray(xcam_players)) {
            xcam_players = array(xcam_players);
          }
          xcam_players[xcam_players.size] = o_obj._player;
        }
      }
      if(xcam_players.size == 0) {
        xcam_players = level.players;
      } else {
        a_xcam_players = xcam_players;
      }
    } else {
      xcam_players = level.players;
    }
    if(isstring(_s.cameraswitcher)) {
      if(!(isDefined(_s.linkxcamtooneplayer) && _s.linkxcamtooneplayer)) {
        callback::on_loadout(&_play_camera_anim_on_player_callback, self);
      }
      camera_v_origin = v_origin;
      camera_v_angles = v_angles;
      camera_start_time = gettime();
      array::thread_all_ents(xcam_players, &_play_camera_anim_on_player, v_origin, v_angles, 0);
      display_dev_info();
    }
    if(isstring(_s.extracamswitcher1)) {
      array::thread_all_ents(xcam_players, &_play_extracam_on_player, 0, _s.extracamswitcher1, v_origin, v_angles);
    }
    if(isstring(_s.extracamswitcher2)) {
      array::thread_all_ents(xcam_players, &_play_extracam_on_player, 1, _s.extracamswitcher2, v_origin, v_angles);
    }
    if(isstring(_s.extracamswitcher3)) {
      array::thread_all_ents(xcam_players, &_play_extracam_on_player, 2, _s.extracamswitcher3, v_origin, v_angles);
    }
    if(isstring(_s.extracamswitcher4)) {
      array::thread_all_ents(xcam_players, &_play_extracam_on_player, 3, _s.extracamswitcher4, v_origin, v_angles);
    }
  }

  function _wait_for_camera_animation(str_cam, n_start_time) {
    self endon("skip_camera_anims");
    if(iscamanimlooping(str_cam)) {
      level waittill("forever");
    } else {
      _wait_server_time(getcamanimtime(str_cam) / 1000, n_start_time);
    }
  }

  function _wait_server_time(n_time, n_start_time = 0) {
    n_len = n_time - (n_time * n_start_time);
    n_len = n_len / 0.05;
    n_len_int = int(n_len);
    if(n_len_int != n_len) {
      n_len = floor(n_len);
    }
    n_server_length = n_len * 0.05;
    wait(n_server_length);
  }

  function play(str_state = "play", a_ents, b_testing = 0, str_mode = "") {
    if(getdvarint("") > 0) {
      printtoprightln("" + _s.name);
    }
    self notify("new_state");
    self endon("new_state");
    if(str_mode == "skip_scene") {
      thread skip_scene(1);
    } else {
      if(str_mode == "skip_scene_player") {
        b_player_scene = 1;
        thread skip_scene(1);
      } else if(!is_skipping_scene() && is_scene_shared_sequence() && !is_scene_shared()) {
        init_scene_sequence_started(0);
      }
    }
    update_scene_sequence();
    _testing = b_testing;
    _str_mode = str_mode;
    if(isDefined(_s.spectateonjoin) && _s.spectateonjoin) {
      level.scene_should_spectate_on_hot_join = 1;
    }
    assign_ents(a_ents);
    if(strstartswith(_str_mode, "capture")) {
      if(get_valid_objects().size) {
        foreach(o_obj in _a_objects) {
          thread[[o_obj]] - > initialize(1);
        }
      }
      thread loop_camera_anim_to_set_up_for_capture();
      capture_player = level.players[0];
      v_origin = get_align_ent().origin;
      if(!isDefined(capture_player.e_capture_link)) {
        capture_player.e_capture_link = util::spawn_model("tag_origin", v_origin);
        capture_player setorigin(v_origin);
        capture_player linkto(level.players[0].e_capture_link);
      } else {
        capture_player.e_capture_link.origin = v_origin;
      }
      wait(15);
      thread _stop_camera_anims();
    }
    self thread sync_with_client_scene("play", b_testing);
    n_start_time = 0;
    if(issubstr(str_mode, "skipto")) {
      args = strtok(str_mode, ":");
      if(isDefined(args[1])) {
        n_start_time = float(args[1]);
      } else {
        n_start_time = 0.95;
      }
      longest_anim_length = 0;
      foreach(s_obj in _a_objects) {
        if(isDefined(s_obj._s.mainanim)) {
          anim_length = getanimlength(s_obj._s.mainanim);
          if(anim_length > longest_anim_length) {
            longest_anim_length = anim_length;
          }
        }
      }
    }
    if(get_valid_objects().size || _s scene::is_igc()) {
      level flagsys::set(_str_name + "_playing");
      _str_state = "play";
      foreach(o_obj in _a_objects) {
        thread[[o_obj]] - > play();
      }
      wait_till_scene_ready();
      level flagsys::set(_str_notify_name + "_ready");
      if(strstartswith(_str_mode, "capture")) {
        adddebugcommand((("" + _str_name) + "") + _str_name);
      }
      if(n_start_time == 0) {
        self thread _play_camera_anims();
      }
      if(is_scene_shared()) {
        display_dev_info();
      }
      if(_n_streamer_req != -1 && !is_skipping_scene()) {
        streamerrequest("play", _s.streamerhint);
      }
      thread _call_state_funcs("play");
      if(_s scene::is_igc()) {
        if(!(isDefined(_s.disablesceneskipping) && _s.disablesceneskipping) && _str_state != "init") {
          trigger_scene_sequence_started(self);
        }
        if(isstring(_s.cameraswitcher)) {
          _wait_for_camera_animation(_s.cameraswitcher, n_start_time);
        } else {
          if(isstring(_s.extracamswitcher1)) {
            _wait_for_camera_animation(_s.extracamswitcher1, n_start_time);
          } else {
            if(isstring(_s.extracamswitcher2)) {
              _wait_for_camera_animation(_s.extracamswitcher2, n_start_time);
            } else {
              if(isstring(_s.extracamswitcher3)) {
                _wait_for_camera_animation(_s.extracamswitcher3, n_start_time);
              } else if(isstring(_s.extracamswitcher4)) {
                _wait_for_camera_animation(_s.extracamswitcher4, n_start_time);
              }
            }
          }
        }
        foreach(o_obj in _a_objects) {
          thread[[o_obj]] - > stop(0, isDefined(o_obj._s.dontclamp) && o_obj._s.dontclamp, 1);
        }
        _e_root notify("scene_done", _str_notify_name);
        thread _call_state_funcs("done");
        if(isDefined(_s.spectateonjoin) && _s.spectateonjoin) {
          level.scene_should_spectate_on_hot_join = undefined;
        }
      } else {
        array::flagsys_wait_any_flag(_a_objects, "done", "main_done");
        if(isDefined(_e_root)) {
          _e_root notify("scene_done", _str_notify_name);
        }
        thread _call_state_funcs("done");
        if(isDefined(_s.spectateonjoin) && _s.spectateonjoin) {
          level.scene_should_spectate_on_hot_join = undefined;
        }
        array::flagsys_wait(_a_objects, "done");
      }
      if(is_looping() || strendswith(_str_mode, "loop")) {
        if(has_init_state()) {
          level flagsys::clear(_str_name + "_playing");
          thread initialize();
        } else {
          level flagsys::clear(_str_name + "_initialized");
          thread play(str_state, undefined, b_testing, str_mode);
        }
      } else {
        if(!strendswith(_str_mode, "single")) {
          thread run_next();
        } else {
          if(!is_skipping_scene()) {
            if(is_scene_shared_sequence()) {
              init_scene_sequence_started(0);
            }
          } else if(isDefined(level.linked_scenes)) {
            arrayremovevalue(level.linked_scenes, _s.name);
          }
          streamer_request_completed();
        }
        if(!_s scene::is_igc() || (!(isDefined(_s.holdcameralastframe) && _s.holdcameralastframe))) {
          thread stop(0, 1);
        }
      }
    } else {
      thread stop(0, 1);
    }
  }

  function is_player_anim_ending_early() {
    max_anim_length = -1;
    player_anim_length = -1;
    foreach(obj in _a_objects) {
      if(isDefined(obj._s.mainanim)) {
        anim_length = getanimlength(obj._s.mainanim);
      }
      if(obj._s.type === "player") {
        player_anim_length = anim_length;
      }
      if(anim_length > max_anim_length) {
        max_anim_length = anim_length;
      }
    }
    return player_anim_length < max_anim_length;
  }

  function get_anim_relative_start_time(animation, n_time) {
    if(!isDefined(n_start_time) || n_start_time == 0 || !isDefined(longest_anim_length) || longest_anim_length == 0) {
      return n_time;
    }
    anim_length = getanimlength(animation);
    is_looping = isanimlooping(animation);
    n_time = (longest_anim_length / anim_length) * n_time;
    if(is_looping) {
      if(n_time > 0.95) {
        n_time = 0.95;
      }
    } else if(n_time > 0.99) {
      n_time = 0.99;
    }
    return n_time;
  }

  function get_objects(str_type) {
    a_ret = [];
    foreach(obj in _a_objects) {
      if(obj._s.type == str_type) {
        if(!isDefined(a_ret)) {
          a_ret = [];
        } else if(!isarray(a_ret)) {
          a_ret = array(a_ret);
        }
        a_ret[a_ret.size] = obj;
      }
    }
    return a_ret;
  }

  function _is_ent_vehicle(ent) {
    return isvehicle(ent) || isvehiclespawner(ent);
  }

  function _is_ent_actor(ent) {
    return isactor(ent) || isactorspawner(ent);
  }

  function _is_ent_player(ent) {
    return isplayer(ent);
  }

  function _assign_ents_by_type(&a_objects, &a_ents, str_type, func_test) {
    if(a_ents.size) {
      a_objects_of_type = get_objects(str_type);
      if(a_objects_of_type.size) {
        foreach(ent in arraycopy(a_ents)) {
          if(isDefined(func_test) && [
              [func_test]
            ](ent)) {
            obj = array::pop_front(a_objects_of_type);
            if(isDefined(obj)) {
              obj._e = ent;
              arrayremovevalue(a_ents, ent, 1);
              arrayremovevalue(a_objects, obj);
              continue;
            }
            break;
          }
        }
      }
    }
    return a_ents.size;
  }

  function _assign_ents_by_name(&a_objects, &a_ents) {
    if(a_ents.size) {
      foreach(str_name, e_ent in arraycopy(a_ents)) {
        foreach(i, o_obj in arraycopy(a_objects)) {
          if(isDefined(o_obj._s.name) && (isDefined(o_obj._s.name) ? "" + o_obj._s.name : "") == (tolower((isDefined(str_name) ? "" + str_name : "")))) {
            o_obj._e = e_ent;
            arrayremoveindex(a_ents, str_name, 1);
            arrayremoveindex(a_objects, i);
            break;
          }
        }
      }
      foreach(i, ent in a_ents) {
        cscriptbundlebase::error(isstring(i), ("" + i) + "");
      }
    }
    return a_ents.size;
  }

  function assign_ents(a_ents) {
    if(!isDefined(a_ents)) {
      a_ents = [];
    } else if(!isarray(a_ents)) {
      a_ents = array(a_ents);
    }
    a_objects = arraycopy(_a_objects);
    if(_assign_ents_by_name(a_objects, a_ents)) {
      if(_assign_ents_by_type(a_objects, a_ents, "player", &_is_ent_player)) {
        if(_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor)) {
          if(_assign_ents_by_type(a_objects, a_ents, "vehicle", &_is_ent_vehicle)) {
            if(_assign_ents_by_type(a_objects, a_ents, "prop")) {
              foreach(ent in a_ents) {
                obj = array::pop(a_objects);
                if(!cscriptbundlebase::error(!isDefined(obj), "No scene object to assign entity too.You might have passed in more than the scene supports.")) {
                  obj._e = ent;
                }
              }
            }
          }
        }
      }
    }
  }

  function sync_with_client_scene(str_state, b_test_run = 0) {
    if(_s.vmtype == "both" && !_s scene::is_igc()) {
      self endon("new_state");
      wait_till_scene_ready();
      n_val = undefined;
      if(b_test_run) {
        switch (str_state) {
          case "stop": {
            n_val = 3;
            break;
          }
          case "init": {
            n_val = 4;
            break;
          }
          case "play": {
            n_val = 5;
            break;
          }
        }
      } else {
        switch (str_state) {
          case "stop": {
            n_val = 0;
            break;
          }
          case "init": {
            n_val = 1;
            break;
          }
          case "play": {
            n_val = 2;
            break;
          }
        }
      }
      level clientfield::set(_s.name, n_val);
    }
  }

  function get_object_id() {
    _n_object_id++;
    return _n_object_id;
  }

  function initialize(a_ents, b_playing = 0) {
    self notify("new_state");
    self endon("new_state");
    self thread sync_with_client_scene("init", _testing);
    assign_ents(a_ents);
    if(get_valid_objects().size > 0) {
      level flagsys::set(_str_name + "_initialized");
      _str_state = "init";
      foreach(o_obj in _a_objects) {
        thread[[o_obj]] - > initialize();
      }
    }
    if(!b_playing) {
      thread _call_state_funcs("init");
    }
    wait_till_scene_ready();
    level flagsys::set(_str_notify_name + "_ready");
    array::flagsys_wait(_a_objects, "done");
    thread stop();
  }

  function get_valid_object_defs() {
    a_obj_defs = [];
    foreach(s_obj in _s.objects) {
      if(_s.vmtype == "server" || s_obj.vmtype == "server") {
        if(isDefined(s_obj.name) || isDefined(s_obj.model) || isDefined(s_obj.initanim) || isDefined(s_obj.mainanim)) {
          if(!(isDefined(s_obj.disabled) && s_obj.disabled)) {
            if(!isDefined(a_obj_defs)) {
              a_obj_defs = [];
            } else if(!isarray(a_obj_defs)) {
              a_obj_defs = array(a_obj_defs);
            }
            a_obj_defs[a_obj_defs.size] = s_obj;
          }
        }
      }
    }
    return a_obj_defs;
  }

  function new_object() {
    return new csceneobject();
  }

  function remove_from_sync_list() {
    if(isDefined(level.scene_sync_list) && isDefined(level.scene_sync_list[_n_request_time])) {
      arrayremovevalue(level.scene_sync_list[_n_request_time], self);
      if(!level.scene_sync_list[_n_request_time].size) {
        level.scene_sync_list[_n_request_time] = undefined;
      }
    }
  }

  function add_to_sync_list() {
    if(!isDefined(level.scene_sync_list)) {
      level.scene_sync_list = [];
    }
    if(!isDefined(level.scene_sync_list[_n_request_time])) {
      level.scene_sync_list[_n_request_time] = [];
    }
    array::add(level.scene_sync_list[_n_request_time], self, 0);
  }

  function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
    if(getdvarint("") > 0) {
      printtoprightln("" + str_scenedef);
    }
    if(isDefined(level.scriptbundles[""][s_scenedef.name])) {
      level.scriptbundles[""][s_scenedef.name].used = 1;
    }
    cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
    if(isDefined(s_scenedef.streamerhint) && s_scenedef.streamerhint != "" && !is_skipping_scene()) {
      _n_streamer_req = streamerrequest("set", s_scenedef.streamerhint);
    }
    _str_notify_name = (isstring(_s.malebundle) ? _s.malebundle : _str_name);
    if(!isDefined(a_ents)) {
      a_ents = [];
    } else if(!isarray(a_ents)) {
      a_ents = array(a_ents);
    }
    if(!cscriptbundlebase::error(a_ents.size > _s.objects.size, "Trying to use more entities than scene supports.")) {
      _e_root = e_align;
      if(!isDefined(level.active_scenes[_str_name])) {
        level.active_scenes[_str_name] = [];
      } else if(!isarray(level.active_scenes[_str_name])) {
        level.active_scenes[_str_name] = array(level.active_scenes[_str_name]);
      }
      level.active_scenes[_str_name][level.active_scenes[_str_name].size] = _e_root;
      if(!isDefined(_e_root.scenes)) {
        _e_root.scenes = [];
      } else if(!isarray(_e_root.scenes)) {
        _e_root.scenes = array(_e_root.scenes);
      }
      _e_root.scenes[_e_root.scenes.size] = self;
      a_objs = get_valid_object_defs();
      foreach(s_obj in a_objs) {
        cscriptbundlebase::add_object([[
            [
              [self]
            ] - > new_object()
          ]] - > first_init(s_obj, self));
      }
      _n_request_time = gettime();
      if(!(isDefined(_s.dontsync) && _s.dontsync)) {
        add_to_sync_list();
      }
      self thread initialize(a_ents);
    }
  }

}

class cawarenesssceneobject: cscriptbundleobjectbase, csceneobject {
  var _e;
  var _str_state;
  var _s;
  var _str_death_anim;
  var _str_death_anim_loop;

  constructor() {}

  destructor() {}

  function _on_alert_run_scene_thread() {
    self endon("play");
    self endon("done");
    _e waittill("alert", str_alert_state);
    if(getdvarint("", 0)) {
      print3d(_e.origin, "", (1, 0, 0), 1, 0.5, 20);
    }
    thread[[csceneobject::scene()]] - > play(str_alert_state);
  }

  function _prepare() {
    if(csceneobject::_prepare()) {
      if(isai(_e)) {
        thread _on_alert_run_scene_thread();
      }
    }
  }

  function play(str_alert_state) {
    flagsys::clear("ready");
    flagsys::clear("done");
    flagsys::clear("main_done");
    _str_state = "play";
    self notify("new_state");
    self endon("new_state");
    self notify("play");
    cscriptbundleobjectbase::log("play");
    waittillframeend();
    switch (str_alert_state) {
      case "low_alert": {
        cscriptbundleobjectbase::log("LOW ALERT");
        if(isDefined(_s.lowalertanim)) {
          _str_death_anim = _s.lowalertanimdeath;
          _str_death_anim_loop = _s.lowalertanimdeathloop;
          csceneobject::_play_anim(_s.lowalertanim);
        }
        break;
      }
      case "high_alert": {
        cscriptbundleobjectbase::log("HIGH ALERT");
        if(isDefined(_s.highalertanim)) {
          _str_death_anim = _s.highalertanimdeath;
          _str_death_anim_loop = _s.highalertanimdeathloop;
          csceneobject::_play_anim(_s.highalertanim);
        }
        break;
      }
      case "combat": {
        cscriptbundleobjectbase::log("COMBAT ALERT");
        if(isDefined(_s.combatalertanim)) {
          _str_death_anim = _s.combatalertanimdeath;
          _str_death_anim_loop = _s.combatalertanimdeathloop;
          csceneobject::_play_anim(_s.combatalertanim);
        }
        break;
      }
      default: {
        cscriptbundleobjectbase::error(1, "Unsupported alert state");
      }
    }
    thread csceneobject::finish();
  }

}

class cawarenessscene: cscriptbundlebase, cscene {
  var _a_objects;
  var _str_name;
  var _str_state;

  constructor() {}

  destructor() {}

  function play(str_awareness_state = "low_alert") {
    self notify("new_state");
    self endon("new_state");
    if(cscene::get_valid_objects().size > 0) {
      foreach(o_obj in _a_objects) {
        thread[[o_obj]] - > play(str_awareness_state);
      }
      level flagsys::set(_str_name + "_playing");
      _str_state = "play";
      cscene::wait_till_scene_ready();
      thread cscene::_call_state_funcs(str_awareness_state);
      array::flagsys_wait_any_flag(_a_objects, "done", "main_done");
      if(cscene::is_looping()) {} else {
        thread cscene::stop();
      }
    } else {
      thread cscene::stop(0, 1);
    }
  }

  function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
    cscene::init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run);
  }

  function new_object() {
    return new cawarenesssceneobject();
  }

}

#namespace scene;

function private prepare_player_model_anim(ent) {
  if(!ent.animtree === "all_player") {
    ent useanimtree($all_player);
    ent.animtree = "all_player";
  }
}

function private prepare_generic_model_anim(ent) {
  if(!ent.animtree === "generic") {
    ent useanimtree($generic);
    ent.animtree = "generic";
  }
}

function get_existing_ent(str_name, b_spawner_only = 0, b_nodes_and_structs = 0) {
  e = undefined;
  if(b_spawner_only) {
    e_array = getspawnerarray(str_name, "script_animname");
    if(e_array.size == 0) {
      e_array = getspawnerarray(str_name, "targetname");
    }
    assert(e_array.size <= 1, "");
    foreach(ent in e_array) {
      if(!isDefined(ent.isdying)) {
        e = ent;
        break;
      }
    }
  } else {
    e = getent(str_name, "animname", 0);
    if(!is_valid_ent(e)) {
      e = getent(str_name, "script_animname");
      if(!is_valid_ent(e)) {
        e = getent(str_name + "_ai", "targetname", 1);
        if(!is_valid_ent(e)) {
          e = getent(str_name + "_vh", "targetname", 1);
          if(!is_valid_ent(e)) {
            e = getent(str_name, "targetname", 1);
            if(!is_valid_ent(e)) {
              e = getent(str_name, "targetname");
              if(!is_valid_ent(e) && b_nodes_and_structs) {
                e = getnode(str_name, "targetname");
                if(!is_valid_ent(e)) {
                  e = struct::get(str_name, "targetname");
                }
              }
            }
          }
        }
      }
    }
  }
  if(!is_valid_ent(e)) {
    e = undefined;
  }
  return e;
}

function is_valid_ent(ent) {
  return isDefined(ent) && (!isDefined(ent.isdying) && !ent ai::is_dead_sentient() || self._s.ignorealivecheck === 1);
}

function synced_delete() {
  self endon("death");
  self.isdying = 1;
  if(isDefined(self.targetname)) {
    self.targetname = self.targetname + "_sync_deleting";
  }
  if(isDefined(self.animname)) {
    self.animname = self.animname + "_sync_deleting";
  }
  if(isDefined(self.script_animname)) {
    self.script_animname = self.script_animname + "_sync_deleting";
  }
  if(!isplayer(self)) {
    sethideonclientwhenscriptedanimcompleted(self);
    self stopanimscripted();
  } else {
    wait(0.05);
    self ghost();
  }
  self notsolid();
  if(isalive(self)) {
    if(issentient(self)) {
      self.ignoreall = 1;
    }
    if(isactor(self)) {
      self pathmode("dont move");
    }
  }
  wait(1);
  self delete();
}

function autoexec __init__sytem__() {
  system::register("scene", &__init__, &__main__, undefined);
}

function __init__() {
  level.scene_object_id = 0;
  level.active_scenes = [];
  level.sceneskippedcount = 0;
  level.wait_for_streamer_hint_scenes = [];
  streamerrequest("clear");
  foreach(s_scenedef in struct::get_script_bundles("scene")) {
    s_scenedef.editaction = undefined;
    s_scenedef.newobject = undefined;
    if(isstring(s_scenedef.femalebundle)) {
      s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
      s_female_bundle.malebundle = s_scenedef.name;
      s_scenedef.s_female_bundle = s_female_bundle;
      s_female_bundle.s_male_bundle = s_scenedef;
    }
    if(isstring(s_scenedef.nextscenebundle)) {
      foreach(s_object in s_scenedef.objects) {
        if(s_object.type === "player") {
          s_object.disabletransitionout = 1;
        }
      }
      s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
      s_next_bundle.dontsync = 1;
      foreach(s_object in s_next_bundle.objects) {
        if(s_object.type === "player") {
          s_object.disabletransitionin = 1;
        }
        s_object.iscutscene = 1;
      }
      if(isDefined(s_next_bundle.femalebundle)) {
        s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
        if(isDefined(s_next_female_bundle)) {
          s_next_female_bundle.dontsync = 1;
          foreach(s_object in s_next_female_bundle.objects) {
            if(s_object.type === "player") {
              s_object.disabletransitionin = 1;
            }
            s_object.iscutscene = 1;
          }
        }
      }
    }
    if(isstring(s_scenedef.streamerhint)) {
      s_cur_bundle = s_scenedef;
      while(true) {
        s_cur_bundle._endstreamerhint = s_scenedef.streamerhint;
        if(isstring(s_cur_bundle.nextscenebundle)) {
          s_cur_bundle = struct::get_script_bundle("scene", s_cur_bundle.nextscenebundle);
        } else {
          break;
        }
      }
    }
    foreach(s_object in s_scenedef.objects) {
      if(s_object.type === "player") {
        if(!isDefined(s_object.cameratween)) {
          s_object.cameratween = 0;
        }
        if(isDefined(s_object.player)) {
          s_object.player--;
        } else {
          s_object.player = 0;
        }
        s_object.name = "player " + (s_object.player + 1);
        s_object.newplayermethod = 1;
        continue;
      }
      s_object.player = undefined;
    }
    if(s_scenedef.vmtype == "both" && !s_scenedef is_igc()) {
      n_clientbits = getminbitcountfornum(3);
      n_clientbits = getminbitcountfornum(6);
      clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int");
    }
  }
  clientfield::register("toplayer", "postfx_igc", 1, 2, "counter");
  clientfield::register("world", "in_igc", 1, 4, "int");
  clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter");
  clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter");
  clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter");
  clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter");
  clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter");
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
}

function remove_invalid_scene_objects(s_scenedef) {
  a_invalid_object_indexes = [];
  foreach(i, s_object in s_scenedef.objects) {
    if(!isDefined(s_object.name) && !isDefined(s_object.model) && !s_object.type === "player") {
      if(!isDefined(a_invalid_object_indexes)) {
        a_invalid_object_indexes = [];
      } else if(!isarray(a_invalid_object_indexes)) {
        a_invalid_object_indexes = array(a_invalid_object_indexes);
      }
      a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
    }
  }
  for(i = a_invalid_object_indexes.size - 1; i >= 0; i--) {
    arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
  }
  return s_scenedef;
}

function __main__() {
  a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
  foreach(s_instance in a_instances) {
    if(isDefined(s_instance.linkto)) {
      s_instance thread _scene_link();
    }
    if(isDefined(s_instance.script_flag_set)) {
      level flag::init(s_instance.script_flag_set);
    }
    if(isDefined(s_instance.scriptgroup_initscenes)) {
      foreach(trig in getEntArray(s_instance.scriptgroup_initscenes, "scriptgroup_initscenes")) {
        s_instance thread _trigger_init(trig);
      }
    }
    if(isDefined(s_instance.scriptgroup_playscenes)) {
      foreach(trig in getEntArray(s_instance.scriptgroup_playscenes, "scriptgroup_playscenes")) {
        s_instance thread _trigger_play(trig);
      }
    }
    if(isDefined(s_instance.scriptgroup_stopscenes)) {
      foreach(trig in getEntArray(s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes")) {
        s_instance thread _trigger_stop(trig);
      }
    }
  }
  level thread on_load_wait();
  level thread run_instances();
}

function private _scene_link() {
  self.e_scene_link = util::spawn_model("tag_origin", self.origin, self.angles);
  e_linkto = getent(self.linkto, "linkname");
  self.e_scene_link linkto(e_linkto);
  util::waittill_any_ents_two(self, "death", e_linkto, "death");
  self.e_scene_link delete();
}

function on_load_wait() {
  util::wait_network_frame();
  util::wait_network_frame();
  level flagsys::set("scene_on_load_wait");
}

function run_instances() {
  foreach(s_instance in struct::get_script_bundle_instances("scene")) {
    if(isDefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2) {
      s_instance thread play();
      continue;
    }
    if(isDefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1) {
      s_instance thread init();
    }
  }
}

function _trigger_init(trig) {
  trig endon("death");
  trig trigger::wait_till();
  a_ents = [];
  if(get_player_count(self.scriptbundlename) > 0) {
    if(isplayer(trig.who)) {
      a_ents[0] = trig.who;
    }
  }
  self thread _init_instance(undefined, a_ents);
}

function _trigger_play(trig) {
  trig endon("death");
  do {
    trig trigger::wait_till();
    a_ents = [];
    if(get_player_count(self.scriptbundlename) > 0) {
      if(isplayer(trig.who)) {
        a_ents[0] = trig.who;
      }
    }
    self thread play(a_ents);
  }
  while(isDefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping);
}

function _trigger_stop(trig) {
  trig endon("death");
  trig trigger::wait_till();
  self thread stop();
}

function add_scene_func(str_scenedef, func, str_state = "play", ...) {
  /
  #
  assert(isDefined(get_scenedef(str_scenedef)), ("" + str_scenedef) + "");
  if(!isDefined(level.scene_funcs)) {
    level.scene_funcs = [];
  }
  if(!isDefined(level.scene_funcs[str_scenedef])) {
    level.scene_funcs[str_scenedef] = [];
  }
  if(!isDefined(level.scene_funcs[str_scenedef][str_state])) {
    level.scene_funcs[str_scenedef][str_state] = [];
  }
  array::add(level.scene_funcs[str_scenedef][str_state], array(func, vararg), 0);
}

function remove_scene_func(str_scenedef, func, str_state = "play") {
  /
  #
  assert(isDefined(get_scenedef(str_scenedef)), ("" + str_scenedef) + "");
  if(!isDefined(level.scene_funcs)) {
    level.scene_funcs = [];
  }
  if(isDefined(level.scene_funcs[str_scenedef]) && isDefined(level.scene_funcs[str_scenedef][str_state])) {
    for(i = level.scene_funcs[str_scenedef][str_state].size - 1; i >= 0; i--) {
      if(level.scene_funcs[str_scenedef][str_state][i][0] == func) {
        arrayremoveindex(level.scene_funcs[str_scenedef][str_state], i);
      }
    }
  }
}

function get_scenedef(str_scenedef) {
  return struct::get_script_bundle("scene", str_scenedef);
}

function get_scenedefs(str_type = "scene") {
  a_scenedefs = [];
  foreach(s_scenedef in struct::get_script_bundles("scene")) {
    if(s_scenedef.scenetype == str_type) {
      if(!isDefined(a_scenedefs)) {
        a_scenedefs = [];
      } else if(!isarray(a_scenedefs)) {
        a_scenedefs = array(a_scenedefs);
      }
      a_scenedefs[a_scenedefs.size] = s_scenedef;
    }
  }
  return a_scenedefs;
}

function spawn(arg1, arg2, arg3, arg4, b_test_run) {
  str_scenedef = arg1;
  assert(isDefined(str_scenedef), "");
  if(isvec(arg2)) {
    v_origin = arg2;
    v_angles = arg3;
    a_ents = arg4;
  } else {
    a_ents = arg2;
    v_origin = arg3;
    v_angles = arg4;
  }
  s_instance = spawnStruct();
  s_instance.origin = (isDefined(v_origin) ? v_origin : (0, 0, 0));
  s_instance.angles = (isDefined(v_angles) ? v_angles : (0, 0, 0));
  s_instance.classname = "scriptbundle_scene";
  s_instance.scriptbundlename = str_scenedef;
  s_instance struct::init();
  s_instance init(str_scenedef, a_ents, undefined, b_test_run);
  return s_instance;
}

function init(arg1, arg2, arg3, b_test_run) {
  if(self == level) {
    if(isstring(arg1)) {
      if(isstring(arg2)) {
        str_value = arg1;
        str_key = arg2;
        a_ents = arg3;
      } else {
        str_value = arg1;
        a_ents = arg2;
      }
      if(isDefined(str_key)) {
        a_instances = struct::get_array(str_value, str_key);
        /
        #
        assert(a_instances.size, ((("" + str_key) + "") + str_value) + "");
      } else {
        a_instances = struct::get_array(str_value, "targetname");
        if(!a_instances.size) {
          a_instances = struct::get_array(str_value, "scriptbundlename");
        }
      }
      if(!a_instances.size) {
        _init_instance(str_value, a_ents, b_test_run);
      } else {
        foreach(s_instance in a_instances) {
          if(isDefined(s_instance)) {
            s_instance thread _init_instance(undefined, a_ents, b_test_run);
          }
        }
      }
    }
  } else {
    if(isstring(arg1)) {
      _init_instance(arg1, arg2, b_test_run);
    } else {
      _init_instance(arg2, arg1, b_test_run);
    }
    return self;
  }
}

function _init_instance(str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0) {
  level flagsys::wait_till("scene_on_load_wait");
  if(array().size && !isinarray(array(), str_scenedef)) {
    return;
  }
  s_bundle = get_scenedef(str_scenedef);
  /
  #
  assert(isDefined(str_scenedef), ("" + (isDefined(self.origin) ? self.origin : "")) + "");
  assert(isDefined(s_bundle), ((("" + (isDefined(self.origin) ? self.origin : "")) + "") + str_scenedef) + "");
  o_scene = get_active_scene(str_scenedef);
  if(!isDefined(o_scene)) {
    if(s_bundle.scenetype == "awareness") {
      o_scene = new cawarenessscene();
    } else {
      o_scene = new cscene();
    }
    s_bundle = _load_female_scene(s_bundle, a_ents);
    [[o_scene]] - > init(s_bundle.name, s_bundle, self, a_ents, b_test_run);
  } else {
    thread[[o_scene]] - > initialize(a_ents, 1);
  }
  return o_scene;
}

function private _load_female_scene(s_bundle, a_ents) {
  b_has_player = 0;
  foreach(s_object in s_bundle.objects) {
    if(!isDefined(s_object)) {
      continue;
    }
    if(s_object.type === "player") {
      b_has_player = 1;
      break;
    }
  }
  if(b_has_player) {
    e_player = undefined;
    if(isplayer(a_ents)) {
      e_player = a_ents;
    } else if(isarray(a_ents)) {
      foreach(ent in a_ents) {
        if(isplayer(ent)) {
          e_player = ent;
          break;
        }
      }
    }
    if(!isDefined(e_player)) {
      e_player = level.activeplayers[0];
    }
    if(isplayer(e_player) && e_player util::is_female()) {
      if(isDefined(s_bundle.femalebundle)) {
        s_female_bundle = struct::get_script_bundle("scene", s_bundle.femalebundle);
        if(isDefined(s_female_bundle)) {
          return s_female_bundle;
        }
      }
    }
  }
  return s_bundle;
}

function play(arg1, arg2, arg3, b_test_run = 0, str_state, str_mode = "") {
  if(getdvarint("") > 0) {
    if(isDefined(arg1) && isstring(arg1)) {
      printtoprightln("" + arg1);
    } else {
      printtoprightln("");
    }
  }
  if(isDefined(arg1) && isstring(arg1) && arg1 == "p7_fxanim_zm_castle_rocket_bell_tower_bundle") {
    arg1 = arg1;
  }
  s_tracker = spawnStruct();
  s_tracker.n_scene_count = 1;
  if(self == level) {
    if(isstring(arg1)) {
      if(isstring(arg2)) {
        str_value = arg1;
        str_key = arg2;
        a_ents = arg3;
      } else {
        str_value = arg1;
        a_ents = arg2;
      }
      str_scenedef = str_value;
      if(isDefined(str_key)) {
        a_instances = struct::get_array(str_value, str_key);
        str_scenedef = undefined;
        /
        #
        assert(a_instances.size, ((("" + str_key) + "") + str_value) + "");
      } else {
        a_instances = struct::get_array(str_value, "targetname");
        if(!a_instances.size) {
          a_instances = struct::get_array(str_value, "scriptbundlename");
        } else {
          str_scenedef = undefined;
        }
      }
      if(isDefined(str_scenedef)) {
        a_active_instances = get_active_scenes(str_scenedef);
        a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
      }
      if(!a_instances.size) {
        self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, undefined, str_mode);
      } else {
        s_tracker.n_scene_count = a_instances.size;
        foreach(s_instance in a_instances) {
          if(isDefined(s_instance)) {
            s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_state, str_mode);
          }
        }
      }
    }
  } else {
    if(isstring(arg1)) {
      self thread _play_instance(s_tracker, arg1, arg2, b_test_run, str_state, str_mode);
    } else {
      self thread _play_instance(s_tracker, arg2, arg1, b_test_run, str_state, str_mode);
    }
  }
  for(i = 0; i < s_tracker.n_scene_count; i++) {
    s_tracker waittill("scene_done");
  }
}

function _play_instance(s_tracker, str_scenedef, a_ents, b_test_run = 0, str_state, str_mode) {
  if(array().size && !isinarray(array(), str_scenedef)) {
    return;
  }
  if(!isDefined(str_scenedef)) {
    str_scenedef = self.scriptbundlename;
  }
  if(self.scriptbundlename === str_scenedef) {
    if(!(isDefined(self.script_play_multiple) && self.script_play_multiple)) {
      if(isDefined(self.scene_played) && self.scene_played && !b_test_run) {
        waittillframeend();
        while(is_playing(str_scenedef)) {
          wait(0.05);
        }
        s_tracker notify("scene_done");
        return;
      }
    }
    self.scene_played = 1;
  }
  o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
  if(isDefined(o_scene)) {
    if(!isDefined(str_mode) || str_mode == "" && [
        [o_scene]
      ] - > should_skip_linked_to_players_scene()) {
      skip_scene(o_scene._s.name, 0, 0, 1);
    }
    thread[[o_scene]] - > play(str_state, a_ents, b_test_run, str_mode);
  }
  self waittillmatch("scene_done");
  if(isDefined(self)) {
    if(isDefined(self.scriptbundlename) && (isDefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping)) {
      self.scene_played = 0;
    }
    if(isDefined(self.script_flag_set)) {
      level flag::set(self.script_flag_set);
    }
  }
  s_tracker notify("scene_done", str_scenedef);
}

function skipto_end(arg1, arg2, arg3, n_time, b_include_players = 0) {
  str_mode = "skipto";
  if(!b_include_players) {
    str_mode = str_mode + "_noplayers";
  }
  if(isDefined(n_time)) {
    str_mode = str_mode + (":" + n_time);
  }
  play(arg1, arg2, arg3, 0, undefined, str_mode);
}

function skipto_end_noai(arg1, arg2, arg3, n_time) {
  str_mode = "skipto_noai_noplayers";
  if(isDefined(n_time)) {
    str_mode = str_mode + (":" + n_time);
  }
  play(arg1, arg2, arg3, 0, undefined, str_mode);
}

function stop(arg1, arg2, arg3) {
  if(self == level) {
    if(isstring(arg1)) {
      if(isstring(arg2)) {
        str_value = arg1;
        str_key = arg2;
        b_clear = arg3;
      } else {
        str_value = arg1;
        b_clear = arg2;
      }
      if(isDefined(str_key)) {
        a_instances = struct::get_array(str_value, str_key);
        /
        #
        assert(a_instances.size, ((("" + str_key) + "") + str_value) + "");
        str_value = undefined;
      } else {
        a_instances = struct::get_array(str_value, "targetname");
        if(!a_instances.size) {
          a_instances = get_active_scenes(str_value);
        } else {
          str_value = undefined;
        }
      }
      foreach(s_instance in arraycopy(a_instances)) {
        if(isDefined(s_instance)) {
          s_instance _stop_instance(b_clear, str_value);
        }
      }
    }
  } else {
    if(isstring(arg1)) {
      _stop_instance(arg2, arg1);
    } else {
      _stop_instance(arg1);
    }
  }
}

function _stop_instance(b_clear = 0, str_scenedef) {
  if(isDefined(self.scenes)) {
    foreach(o_scene in arraycopy(self.scenes)) {
      str_scene_name = [
        [o_scene]
      ] - > get_name();
      if(!isDefined(str_scenedef) || str_scene_name == str_scenedef) {
        thread[[o_scene]] - > stop(b_clear);
      }
    }
  }
}

function has_init_state(str_scenedef) {
  s_scenedef = get_scenedef(str_scenedef);
  foreach(s_obj in s_scenedef.objects) {
    if(!(isDefined(s_obj.disabled) && s_obj.disabled) && s_obj _has_init_state()) {
      return true;
    }
  }
  return false;
}

function _has_init_state() {
  return isDefined(self.spawnoninit) && self.spawnoninit || isDefined(self.initanim) || isDefined(self.initanimloop) || (isDefined(self.firstframe) && self.firstframe);
}

function get_prop_count(str_scenedef) {
  return _get_type_count("prop", str_scenedef);
}

function get_vehicle_count(str_scenedef) {
  return _get_type_count("vehicle", str_scenedef);
}

function get_actor_count(str_scenedef) {
  return _get_type_count("actor", str_scenedef);
}

function get_player_count(str_scenedef) {
  return _get_type_count("player", str_scenedef);
}

function _get_type_count(str_type, str_scenedef) {
  s_scenedef = (isDefined(str_scenedef) ? get_scenedef(str_scenedef) : get_scenedef(self.scriptbundlename));
  n_count = 0;
  foreach(s_obj in s_scenedef.objects) {
    if(isDefined(s_obj.type)) {
      if(tolower(s_obj.type) == tolower(str_type)) {
        n_count++;
      }
    }
  }
  return n_count;
}

function is_active(str_scenedef) {
  if(self == level) {
    return get_active_scenes(str_scenedef).size > 0;
  }
  return isDefined(get_active_scene(str_scenedef));
}

function is_playing(str_scenedef) {
  if(self == level) {
    return level flagsys::get(str_scenedef + "_playing");
  }
  if(!isDefined(str_scenedef)) {
    str_scenedef = self.scriptbundlename;
  }
  o_scene = get_active_scene(str_scenedef);
  if(isDefined(o_scene)) {
    return o_scene._str_state === "play";
  }
  return 0;
}

function is_ready(str_scenedef) {
  if(self == level) {
    return level flagsys::get(str_scenedef + "_ready");
  }
  if(!isDefined(str_scenedef)) {
    str_scenedef = self.scriptbundlename;
  }
  o_scene = get_active_scene(str_scenedef);
  if(isDefined(o_scene)) {
    return o_scene flagsys::get("ready");
  }
  return 0;
}

function get_active_scenes(str_scenedef) {
  if(!isDefined(level.active_scenes)) {
    level.active_scenes = [];
  }
  if(isDefined(str_scenedef)) {
    return (isDefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
  }
  a_active_scenes = [];
  foreach(str_scenedef, _ in level.active_scenes) {
    a_active_scenes = arraycombine(a_active_scenes, level.active_scenes[str_scenedef], 0, 0);
  }
  return a_active_scenes;
}

function get_active_scene(str_scenedef) {
  if(isDefined(str_scenedef) && isDefined(self.scenes)) {
    foreach(o_scene in self.scenes) {
      if(([[o_scene]] - > get_name()) == str_scenedef) {
        return o_scene;
      }
    }
  }
}

function delete_scene_data(str_scenename) {
  if(isDefined(level.scriptbundles["scene"][str_scenename])) {
    level.scriptbundles["scene"][str_scenename] = undefined;
  }
}

function is_igc() {
  return isstring(self.cameraswitcher) || isstring(self.extracamswitcher1) || isstring(self.extracamswitcher2) || isstring(self.extracamswitcher3) || isstring(self.extracamswitcher4);
}

function scene_disable_player_stuff(b_hide_hud = 1) {
  if(getdvarint("") > 0) {
    printtoprightln("");
  }
  self notify("scene_disable_player_stuff");
  self notify("kill_hint_text");
  self disableoffhandweapons();
  if(b_hide_hud) {
    set_igc_active(1);
    level notify("disable_cybercom", self, 1);
    self util::show_hud(0);
    util::wait_network_frame();
    self notify("delete_weapon_objects");
  }
}

function scene_enable_player_stuff(b_hide_hud = 1) {
  if(getdvarint("") > 0) {
    printtoprightln("");
  }
  self endon("scene_disable_player_stuff");
  self endon("disconnect");
  wait(0.5);
  self enableoffhandweapons();
  if(b_hide_hud) {
    set_igc_active(0);
    level notify("enable_cybercom", self);
    self notify("scene_enable_cybercom");
    self util::show_hud(1);
  }
}

function updateigcviewtime(b_in_igc) {
  if(b_in_igc && !isDefined(level.igcstarttime)) {
    level.igcstarttime = gettime();
  } else if(!b_in_igc && isDefined(level.igcstarttime)) {
    igcviewtimesec = gettime() - level.igcstarttime;
    level.igcstarttime = undefined;
    foreach(player in level.players) {
      if(!isDefined(player.totaligcviewtime)) {
        player.totaligcviewtime = 0;
      }
      player.totaligcviewtime = player.totaligcviewtime + (int(igcviewtimesec / 1000));
    }
  }
}

function set_igc_active(b_in_igc) {
  n_ent_num = self getentitynumber();
  n_players_in_igc_field = level clientfield::get("in_igc");
  if(b_in_igc) {
    n_players_in_igc_field = n_players_in_igc_field | (1 << n_ent_num);
  } else {
    n_players_in_igc_field = n_players_in_igc_field &(~(1 << n_ent_num));
  }
  updateigcviewtime(b_in_igc);
  level clientfield::set("in_igc", n_players_in_igc_field);
}

function is_igc_active() {
  n_players_in_igc = level clientfield::get("in_igc");
  n_entnum = self getentitynumber();
  return n_players_in_igc &(1 << n_entnum);
}

function is_capture_mode() {
  str_mode = getdvarstring("scene_menu_mode", "default");
  if(issubstr(str_mode, "capture")) {
    return true;
  }
  return false;
}

function should_spectate_on_join() {
  return isDefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join;
}

function wait_until_spectate_on_join_completes() {
  while(isDefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join) {
    wait(0.05);
  }
}

function skip_scene(scene_name, b_sequence, b_player_scene, b_check_linked_scene) {
  if(!isDefined(scene_name)) {
    if(isDefined(level.shared_scene_sequence_name)) {
      scene_name = level.shared_scene_sequence_name;
    }
    if(!isDefined(scene_name)) {
      if(isDefined(level.players) && isDefined(level.players[0].current_scene)) {
        scene_name = level.players[0].current_scene;
      }
      if(!isDefined(scene_name)) {
        foreach(player in level.players) {
          if(isDefined(player.current_scene)) {
            scene_name = player.current_scene;
            break;
          }
        }
      }
    }
  }
  if(getdvarint("") > 0) {
    if(isDefined(scene_name)) {
      printtoprightln((("" + scene_name) + "") + gettime(), (1, 0.5, 0));
    } else {
      printtoprightln("" + gettime(), (1, 0.5, 0));
    }
  }
  if(!(isDefined(b_sequence) && b_sequence) && !isDefined(b_player_scene)) {
    foreach(player in level.players) {
      if(isDefined(player.current_scene) && player.current_scene == scene_name) {
        b_player_scene = 1;
        break;
      }
    }
  }
  if(!(isDefined(b_sequence) && b_sequence) && (isDefined(b_player_scene) && b_player_scene)) {
    a_instances = get_active_scenes(scene_name);
    b_can_skip_player_scene = 0;
    foreach(s_instance in arraycopy(a_instances)) {
      if(isDefined(s_instance)) {
        b_shared_scene = s_instance _skip_scene(scene_name, b_sequence, 1, 0);
        if(b_shared_scene == 2) {
          break;
        }
        if(b_shared_scene == 1) {
          b_can_skip_player_scene = 1;
          break;
        }
      }
    }
    if(isDefined(b_can_skip_player_scene) && b_can_skip_player_scene) {
      a_instances = get_active_scenes();
      foreach(s_instance in arraycopy(a_instances)) {
        if(isDefined(s_instance)) {
          s_instance _skip_scene(scene_name, b_sequence, 0, 1);
        }
      }
    } else {
      level.shared_scene_sequence_started = undefined;
      level.shared_scene_sequence_name = undefined;
    }
    return;
  }
  a_instances = struct::get_array(scene_name, "targetname");
  if(!a_instances.size) {
    a_instances = get_active_scenes(scene_name);
  }
  foreach(s_instance in arraycopy(a_instances)) {
    if(isDefined(s_instance)) {
      s_instance _skip_scene(scene_name, b_sequence, b_player_scene, b_check_linked_scene);
    }
  }
}

function _skip_scene(skipped_scene_name, b_sequence, b_player_scene, b_check_linked_scene) {
  b_shared_scene = 0;
  if(isDefined(self.scenes)) {
    foreach(o_scene in arraycopy(self.scenes)) {
      if(isDefined(o_scene.skipping_scene) && o_scene.skipping_scene) {
        continue;
      }
      if(!(isDefined(b_sequence) && b_sequence) && (isDefined(b_player_scene) && b_player_scene) && (!(isDefined(b_check_linked_scene) && b_check_linked_scene))) {
        if(o_scene._s.name === skipped_scene_name) {
          if(isDefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
            return 2;
          }
          if(o_scene._str_state === "init") {
            continue;
          }
          b_shared_scene = 1;
        } else {
          if(!isDefined(skipped_scene_name)) {
            if([
                [o_scene]
              ] - > is_scene_shared()) {
              if(isDefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
                return 2;
              }
              if(o_scene._str_state === "init") {
                continue;
              }
              b_shared_scene = 1;
            } else {
              continue;
            }
          } else {
            continue;
          }
        }
      }
      str_scene_name = [
        [o_scene]
      ] - > get_name();
      if(!(isDefined(b_sequence) && b_sequence)) {
        b_linked_scene = array::contains(level.linked_scenes, str_scene_name);
        if(isDefined(b_check_linked_scene) && b_check_linked_scene && (!b_linked_scene || (isDefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping))) {
          continue;
        }
        if(!b_linked_scene && o_scene._str_state === "init") {
          continue;
        }
        if(!isDefined(skipped_scene_name) || str_scene_name == skipped_scene_name || (b_linked_scene && (!(isDefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping)))) {
          if(!isDefined(skipped_scene_name) || str_scene_name == skipped_scene_name && (isDefined(b_player_scene) && b_player_scene) && (!(isDefined(b_check_linked_scene) && b_check_linked_scene)) && !b_linked_scene) {
            b_shared_scene = 1;
            o_scene.b_player_scene = 1;
            level.player_skipping_scene = str_scene_name;
          }
          o_scene.skipping_scene = 1;
          thread[[o_scene]] - > skip_scene(b_sequence);
        }
        continue;
      }
      o_scene.b_player_scene = b_player_scene;
      o_scene.skipping_scene = 1;
      thread[[o_scene]] - > skip_scene(b_sequence);
    }
  }
  return b_shared_scene;
}

function add_player_linked_scene(linked_scene_str) {
  if(!isDefined(level.linked_scenes)) {
    level.linked_scenes = [];
  }
  array::add(level.linked_scenes, linked_scene_str);
}

function remove_player_linked_scene(linked_scene_str) {
  if(isDefined(level.linked_scenes)) {
    arrayremovevalue(level.linked_scenes, linked_scene_str);
  }
}

function waittill_skip_sequence_completed() {
  while(isDefined(level.player_skipping_scene)) {
    wait(0.05);
  }
}

function is_skipping_in_progress() {
  return isDefined(level.player_skipping_scene);
}

function watch_scene_skip_requests() {
  self endon("disconnect");
  while(true) {
    level waittill("scene_sequence_started");
    self thread should_skip_scene_loop();
    self thread watch_scene_ending();
    self thread watch_scene_skipping();
    level waittill("scene_sequence_ended");
  }
}

function clear_scene_skipping_ui() {
  level endon("scene_sequence_started");
  if(isDefined(self.scene_skip_timer)) {
    self.scene_skip_timer = undefined;
  }
  if(isDefined(self.scene_skip_start_time)) {
    self.scene_skip_start_time = undefined;
  }
  foreach(player in level.players) {
    if(isDefined(player.skip_scene_menu_handle)) {
      player closeluimenu(player.skip_scene_menu_handle);
      player.skip_scene_menu_handle = undefined;
    }
  }
}

function watch_scene_ending() {
  self endon("disconnect");
  self endon("scene_being_skipped");
  level waittill("scene_sequence_ended");
  clear_scene_skipping_ui();
}

function watch_scene_skipping() {
  self endon("disconnect");
  level endon("scene_sequence_ended");
  self waittill("scene_being_skipped");
  level.sceneskippedcount++;
  clear_scene_skipping_ui();
}

function should_skip_scene_loop() {
  self endon("disconnect");
  level endon("scene_sequence_ended");
  b_skip_scene = 0;
  clear_scene_skipping_ui();
  wait(0.05);
  foreach(player in level.players) {
    if(isDefined(player.skip_scene_menu_handle)) {
      player closeluimenu(player.skip_scene_menu_handle);
      wait(0.05);
    }
    player.skip_scene_menu_handle = player openluimenu("CPSkipSceneMenu");
    player setluimenudata(player.skip_scene_menu_handle, "showSkipButton", 0);
    player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 0);
    player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
  }
  while(true) {
    if(self any_button_pressed() && (!(isDefined(level.chyron_text_active) && level.chyron_text_active))) {
      if(!isDefined(self.scene_skip_timer)) {
        self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 1);
      }
      self.scene_skip_timer = gettime();
    } else if(isDefined(self.scene_skip_timer)) {
      if((gettime() - self.scene_skip_timer) > 3000) {
        self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 2);
        self.scene_skip_timer = undefined;
      }
    }
    if(self primarybuttonpressedlocal() && (!(isDefined(level.chyron_text_active) && level.chyron_text_active))) {
      if(!isDefined(self.scene_skip_start_time)) {
        foreach(player in level.players) {
          if(player ishost()) {
            player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", gettime() + 2500);
            continue;
          }
          if(isDefined(player.skip_scene_menu_handle)) {
            player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 1);
          }
        }
        self.scene_skip_start_time = gettime();
      } else if((gettime() - self.scene_skip_start_time) > 2500) {
        b_skip_scene = 1;
        break;
      }
    } else if(isDefined(self.scene_skip_start_time)) {
      foreach(player in level.players) {
        if(player ishost()) {
          player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
          continue;
        }
        if(isDefined(player.skip_scene_menu_handle)) {
          player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 2);
        }
      }
      self.scene_skip_start_time = undefined;
    }
    if(isDefined(level.chyron_text_active) && level.chyron_text_active) {
      while(isDefined(level.chyron_text_active) && level.chyron_text_active) {
        wait(0.05);
      }
      wait(3);
    }
    wait(0.05);
  }
  if(b_skip_scene) {
    self playSound("uin_igc_skip");
    self notify("scene_being_skipped");
    level notify("scene_skip_sequence_started");
    skip_scene(level.shared_scene_sequence_name, 0, 1);
  }
}

function any_button_pressed() {
  if(self actionslotonebuttonpressed()) {
    return true;
  }
  if(self actionslottwobuttonpressed()) {
    return true;
  }
  if(self actionslotthreebuttonpressed()) {
    return true;
  }
  if(self actionslotfourbuttonpressed()) {
    return true;
  }
  if(self jumpbuttonpressed()) {
    return true;
  }
  if(self stancebuttonpressed()) {
    return true;
  }
  if(self weaponswitchbuttonpressed()) {
    return true;
  }
  if(self reloadbuttonpressed()) {
    return true;
  }
  if(self fragbuttonpressed()) {
    return true;
  }
  if(self throwbuttonpressed()) {
    return true;
  }
  if(self attackbuttonpressed()) {
    return true;
  }
  if(self secondaryoffhandbuttonpressed()) {
    return true;
  }
  if(self meleebuttonpressed()) {
    return true;
  }
  return false;
}

function on_player_connect() {
  if(self ishost()) {
    self thread watch_scene_skip_requests();
  }
}

function on_player_disconnect() {
  self set_igc_active(0);
}

function add_scene_ordered_notetrack(group_name, str_note) {
  if(!isDefined(level.scene_ordered_notetracks)) {
    level.scene_ordered_notetracks = [];
  }
  group_obj = level.scene_ordered_notetracks[group_name];
  if(!isDefined(group_obj)) {
    group_obj = spawnStruct();
    group_obj.count = 0;
    group_obj.current_count = 0;
    level.scene_ordered_notetracks[group_name] = group_obj;
  }
  group_obj.count++;
  self thread _wait_for_ordered_notify(group_obj.count - 1, group_obj, group_name, str_note);
}

function private _wait_for_ordered_notify(id, group_obj, group_name, str_note) {
  self waittill(str_note);
  if(group_obj.current_count == id) {
    group_obj.current_count++;
    self notify("scene_" + str_note);
    wait(0.05);
    if(group_obj.current_count == group_obj.count) {
      group_obj.pending_notifies = undefined;
      level.scene_ordered_notetracks[group_name] = undefined;
    } else if(isDefined(group_obj.pending_notifies) && (group_obj.current_count + group_obj.pending_notifies.size) == group_obj.count) {
      self thread _fire_ordered_notitifes(group_obj, group_name);
    }
  } else {
    if(!isDefined(group_obj.pending_notifies)) {
      group_obj.pending_notifies = [];
    }
    notetrack = spawnStruct();
    notetrack.id = id;
    notetrack.str_note = str_note;
    for(i = 0; i < group_obj.pending_notifies.size && group_obj.pending_notifies[i].id < id; i++) {}
    arrayinsert(group_obj.pending_notifies, notetrack, i);
    if((group_obj.current_count + group_obj.pending_notifies.size) == group_obj.count) {
      self thread _fire_ordered_notitifes(group_obj, group_name);
    }
  }
}

function private _fire_ordered_notitifes(group_obj, group_name) {
  if(isDefined(group_obj.pending_notifies)) {
    while(group_obj.pending_notifies.size > 0) {
      self notify("scene_" + group_obj.pending_notifies[0].str_note);
      arrayremoveindex(group_obj.pending_notifies, 0);
      wait(0.05);
    }
  }
  group_obj.pending_notifies = undefined;
  level.scene_ordered_notetracks[group_name] = undefined;
}

function add_wait_for_streamer_hint_scene(str_scene_name) {
  if(!isDefined(level.wait_for_streamer_hint_scenes)) {
    level.wait_for_streamer_hint_scenes = [];
  }
  array::add(level.wait_for_streamer_hint_scenes, str_scene_name);
}