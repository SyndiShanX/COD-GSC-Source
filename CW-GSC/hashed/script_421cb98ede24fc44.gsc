/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_421cb98ede24fc44.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace namespace_31aff1e6;

function private autoexec __init__system__() {
  system::register(#"ice_slide", &preload, &postload, undefined, undefined);
}

function preload() {
  clientfield::register("toplayer", "ice_slide_postfx", 1, 1, "int");
  clientfield::register("toplayer", "ice_slide_looping_fx", 1, 2, "int");
  clientfield::register("toplayer", "ice_slide_dof", 1, 3, "int");
  clientfield::register("toplayer", "ice_slide_fov", 1, 1, "int");
  clientfield::register("toplayer", "ice_slide_landing_fx_dirt", 1, 1, "counter");
}

function postload() {
  var_547465a0 = getEntArray("ice_slide", "targetname");

  foreach(var_fa0bcfcc in var_547465a0) {
    var_fa0bcfcc callback::on_trigger(&function_a8fc3bf1);
  }
}

function function_a8fc3bf1(s_info) {
  e_player = s_info.activator;

  if(isalive(e_player) && !is_true(e_player.var_6a81e560)) {
    e_player.var_6a81e560 = 1;
    e_player setmovespeedscale(0);

    if(!is_true(self.var_859762f6)) {
      e_player playrumbleonentity(#"jump_rumble_start");
      snd::play("evt_slide_downhill_start_lr", e_player);
      var_24559b62 = snd::play("evt_slide_downhill_loop_lr", e_player);
      e_player playrumblelooponentity(#"hash_6e6bf5e1aede5efd");
      e_player thread function_2915e3aa();
      e_player thread function_803405ff();
      e_player val::set(#"ice_slide", "allow_prone", 0);
      e_player val::set(#"ice_slide", "allow_jump", 0);
      e_player val::set(#"ice_slide", "allow_stand", 0);
      e_player clientfield::set_to_player("ice_slide_postfx", 1);
      e_player thread clientfield::set_to_player("ice_slide_fov", 1);
      assert(isDefined(self.str_location), "<dev string:x38>");

      switch (self.str_location) {
        case # "hash_615b4319c8177682":
          e_player clientfield::set_to_player("ice_slide_looping_fx", 1);
          e_player thread clientfield::set_to_player("ice_slide_dof", 1);
          break;
        case # "server_reveal":
          e_player clientfield::set_to_player("ice_slide_looping_fx", 1);
          e_player thread clientfield::set_to_player("ice_slide_dof", 1);
          break;
        case # "server_descent":
          e_player clientfield::set_to_player("ice_slide_looping_fx", 1);
          e_player thread clientfield::set_to_player("ice_slide_dof", 2);
          break;
        case # "amerika":
          e_player clientfield::set_to_player("ice_slide_looping_fx", 2);
          e_player thread clientfield::set_to_player("ice_slide_dof", 2);
          break;
        default:
          assert(0, "<dev string:x6f>");
          break;
      }
    } else {
      e_player playrumbleonentity(#"jump_rumble_start");
      snd::play("evt_slide_downhill_start_lr", e_player);
    }

    while(isalive(e_player) && e_player istouching(self)) {
      waitframe(1);
    }

    if(isDefined(e_player)) {
      e_player playrumbleonentity("jump_rumble_end");
      earthquake(0.4, 1, e_player.origin, 64);

      if(!is_true(self.var_859762f6)) {
        e_player clientfield::set_to_player("ice_slide_looping_fx", 0);
        e_player clientfield::set_to_player("ice_slide_postfx", 0);
        e_player thread clientfield::set_to_player("ice_slide_fov", 0);

        switch (self.str_location) {
          case # "server_reveal":
            e_player thread clientfield::set_to_player("ice_slide_dof", 3);
            break;
          case # "hash_615b4319c8177682":
          case # "server_descent":
          case # "amerika":
            e_player thread clientfield::set_to_player("ice_slide_dof", 4);
            break;
          default:
            assert(0, "<dev string:x6f>");
            break;
        }

        if(is_true(self.var_5739c21f) && isDefined(self.var_51e34a4e)) {
          switch (self.var_51e34a4e) {
            case # "ice":
              exploder::exploder("first_slide_impact");
              break;
            case # "dirt":
              e_player clientfield::increment_to_player("ice_slide_landing_fx_dirt", 1);
              break;
            default:
              assert(0, "<dev string:xce>");
              break;
          }
        }
      }

      self.var_859762f6 = 1;
      waitframe(1);
      e_player notify(#"hash_21e7754db7821ef8");
      snd::play("evt_slide_downhill_stop_lr", e_player);

      if(isDefined(var_24559b62)) {
        util::delay(0.25, undefined, &snd::stop, var_24559b62);
        var_24559b62 = undefined;
      }

      e_player stoprumble(#"hash_6e6bf5e1aede5efd");
      e_player.var_6a81e560 = 0;
      e_player val::reset_all(#"ice_slide");
      e_player setmovespeedscale(1);
      e_player playrumbleonentity("jump_rumble_end");

      if(isalive(e_player)) {
        e_player setstance("stand");
      }
    }
  }
}

function function_803405ff() {
  self endon(#"death", #"hash_21e7754db7821ef8");
  str_stance = self getstance();

  switch (str_stance) {
    case # "stand":
      self setstance("crouch");
      wait 0.2;
      break;
    case # "prone":
      self setstance("crouch");
      wait 1;
      break;
  }
}

function function_2915e3aa() {
  self endon(#"hash_21e7754db7821ef8", #"death");

  while(true) {
    n_magnitude = randomfloatrange(0.075, 0.225);
    earthquake(n_magnitude, 0.3, self.origin, 64);
    wait 0.3;
  }
}