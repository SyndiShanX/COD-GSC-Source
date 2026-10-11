/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c63dbe7d4c85e19.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_200c1cd00f9ab885;
#using script_3badb8914eb5ac16;
#using script_4d09faa32d8aa068;
#using script_52f2d330c7a21cb6;
#using script_7edf952f8921aa6b;
#using script_bd0d3e8f9ff5c11;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function precache(params) {
  function_a53f4a78a75cbd41(params);
  function_1fa609d0d2a30cf9(params);
  settings = zombie_utils::function_cb7771bf461049eb(params);

  if(isDefined(settings) && isDefined(settings.var_2f9ea41a609494be)) {
    utility::add_fx("deathworm_weakpoint_hit_vfx", settings.var_2f9ea41a609494be);
  }
}

function private function_b0fc1ad0235df745(params) {
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &function_c8c10b313b3fcf09);
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_51534f263388ce5a);
  function_70332948ed09c6b1();
}

function function_5a38039db1b92712(taskid) {
  assert(isDefined(self.zombieaisetting));
  zombie_init_ai(self.zombieaisetting);
  assert(isDefined(self.zombieaisettings.var_e58a65b7a8f5973c));
  callback::add("on_first_ai_init", &function_b0fc1ad0235df745);
  init_metabones();
  init_arena();
  function_b5e57408c7878df7(&function_9978cd595b421511);
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  self.allowfriendlyfire = 1;
  self.var_54b7951c49363c15 = 1;
  ent_flag_set("snapshot_immunity");
  self.var_8f1d8328f7a9091b = &function_a5c6032799e412cd;
  self.var_c54a21ea717fe8a5 = &function_54c2056eaaf773b7;
  self.var_f8adf1aaec88d636 = function_a5c6032799e412cd();
  self.var_b1a22aae6e91a528 = function_ad0a791562fc8bfd();
  self.var_598c79ae8b7b69ea = gettime();
  val::set("deathworm_no_instakill", "damageshield", 1);
  self.var_fa1a1806d30a40e1 = self.subclass == "zombie_deathworm_boss";
  thread initscriptable();
  thread function_a7b05e9a9ec0a5bb();
  function_54f789069ca4eded();
  return anim.success;
}

function private function_a7b05e9a9ec0a5bb() {
  self endon("death");
  wait 4;

  while(self.health > 0) {
    if(isDefined(level.var_e5bcf78298395b30) && isDefined(level.var_14a0183a6880d101)) {
      foreach(player in level.players) {
        if(isalive(player)) {
          if(distance2dsquared(self.origin, player.origin) < 256000000) {
            if(isDefined(self.zombieaisettings.var_e58a65b7a8f5973c.bosshealthbar)) {
              player[[level.var_e5bcf78298395b30]](self.zombieaisettings.var_e58a65b7a8f5973c.bosshealthbar, self);
            }
          } else {
            player[[level.var_14a0183a6880d101]]();
          }

          continue;
        }

        player[[level.var_14a0183a6880d101]]();
      }
    }

    wait 2;
  }
}

function private function_51534f263388ce5a(sparams) {
  if(isDefined(level.var_9b6d08310d681466)) {
    foreach(player in level.players) {
      newhealth = self.health - int(sparams.idamage);
      player[[level.var_9b6d08310d681466]](newhealth, self.maxhealth);
      player[[level.var_e06bf06822c7531f]](newhealth);
    }
  }

  self.var_ef8c3662cc722e80 = isDefined(self.var_ef8c3662cc722e80) ? self.var_ef8c3662cc722e80 : [];
  damage_struct = undefined;

  foreach(struct in self.var_ef8c3662cc722e80) {
    if(isDefined(struct) && is_equal(struct.player, self)) {
      damage_struct = struct;
      break;
    }
  }

  if(!isDefined(damage_struct)) {
    damage_struct = {
      #damage: 0, #player: self
    };
    self.var_ef8c3662cc722e80 = array_add(self.var_ef8c3662cc722e80, damage_struct);
  }

  damage_struct.damage += sparams.idamage;

  if(self.health <= 10) {
    val::reset_all("deathworm_no_instakill");
  }

  if(istrue(sparams.biscritical)) {
    function_3677f2be30fdd581(sparams.metabonename + "_impact", "weakpoint_impact");
  }
}

function private initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();
  utility::function_3ab9164ef76940fd("base", "base_on");
}

function private function_c8c10b313b3fcf09(params) {
  foreach(player in level.players) {
    if(isDefined(level.var_14a0183a6880d101)) {
      player[[level.var_14a0183a6880d101]]();
    }
  }

  if(!isPlayer(params.eattacker) || isDefined(params.idamage) && params.idamage > self.maxhealth * 0.5) {
    weaponname = isDefined(params.sweapon) ? params.sweapon.basename : "";
    damage = isDefined(params.idamage) ? string(params.idamage) : "";
    entitynum = isDefined(params.eattacker) ? string(params.eattacker getentitynumber()) : "";
    classname = isDefined(params.eattacker) && isDefined(params.eattacker.classname) ? params.eattacker.classname : "";
    error_msg = "Deathworm slain incorrectly. Weapon: " + weaponname + " - Damage: " + damage + " - EntNum: " + entitynum + " - class: " + classname;
    assertmsg(error_msg);
    logstring(error_msg);
  }

  if(isDefined(params.body)) {
    params.body function_3ab9164ef76940fd("base", "off");
    function_6671940a6e85ff8a(params.body);
    params.body forcenetfieldhighlod(1);
    params.body setcorpseremovetimer(10);
    params.body waittill("death_hide");
    params.body function_3ab9164ef76940fd("death_reveal", "death_reveal");
    params.body setscriptablepartstate("ambient_audio", "off");
    wait 5;

    if(isDefined(params.body)) {
      params.body delete();
    }
  }
}

function function_a8c9248308033e4e() {
  return false;
}

function private function_9978cd595b421511(params) {
  damage_cap = 0.1;

  if(isexplosivedamagemod(params.smeansofdeath)) {
    damage_cap = 0.2;
  }

  val::set("deathworm_no_instakill_but_allow_damage", "damageshield", 0);
  thread function_c00df6bbc0f72cb0();
  var_555594958021f88c = 0.002;
  var_c1b1350af8c36f31 = 0.1;
  params.damagemaxhealthcap = min(var_c1b1350af8c36f31, params.damagemaxhealthcap);

  if(function_9f798527e4e931c3(params)) {
    return (params.idamage * damage_cap);
  }

  damage = params.idamage;

  if(istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_11f14b975b25629e) && self.var_f8adf1aaec88d636 > 1) {
    if(issharedfuncdefined("zombie", "get_pap_level") && isDefined(params.sweapon) && isPlayer(params.eattacker)) {
      n_pap_level = params.eattacker function_af5127390d3221e9(params.sweapon);

      if(n_pap_level >= 3) {
        damage *= 0.6;
      }
    }
  }

  if(istrue(self.var_b1a22aae6e91a528) || istrue(self.var_fa1a1806d30a40e1)) {
    if(self.var_f8adf1aaec88d636 < 4) {
      if(!time_has_passed(self.var_598c79ae8b7b69ea, 180)) {
        damage *= 0.6;
      }
    } else if(!time_has_passed(self.var_598c79ae8b7b69ea, 300)) {
      if(self.var_f8adf1aaec88d636 >= 4 && self.var_f8adf1aaec88d636 < 7) {
        damage *= 0.4;
      } else if(self.var_f8adf1aaec88d636 >= 7 && self.var_f8adf1aaec88d636 < 13) {
        damage *= 0.3;
      } else if(self.var_f8adf1aaec88d636 >= 13 && self.var_f8adf1aaec88d636 < 19) {
        damage *= 0.2;
      } else if(self.var_f8adf1aaec88d636 >= 19) {
        damage *= 0.15;
      }
    }
  }

  if(damage > self.maxhealth * var_555594958021f88c) {
    damage = (damage - self.maxhealth * var_555594958021f88c) * 0.3 + self.maxhealth * var_555594958021f88c;
  }

  return damage;
}

function private function_c00df6bbc0f72cb0() {
  self endon("death");
  waittillframeend();
  val::reset_all("deathworm_no_instakill_but_allow_damage");
}

function private function_9f798527e4e931c3(damage_struct) {
  if(!isDefined(damage_struct.metabonename)) {
    return true;
  }

  return false;
}

function function_a5c6032799e412cd() {
  if(getdvarint(@ "hash_e7da760b9a7ca2c1", -1) > 0) {
    return getdvarint(@ "hash_e7da760b9a7ca2c1", -1);
  }

  nearby_players = getplayersinradiussharedfunc(self.origin, 3000);
  var_de7821bc51ab43a0 = nearby_players.size;
  return var_de7821bc51ab43a0;
}

function function_54c2056eaaf773b7() {
  if(getdvarint(@ "hash_4ed7ea900c346cdb", -1) > 0) {
    return getdvarint(@ "hash_4ed7ea900c346cdb", -1);
  }

  nearby_players = getplayersinradiussharedfunc(self.origin, 3000);

  if(nearby_players.size <= 0) {
    return 1;
  }

  alive_count = 0;

  foreach(player in nearby_players) {
    if(isalive(player) && !istrue(player.inlaststand)) {
      alive_count += 1;
    }
  }

  return alive_count / nearby_players.size;
}

function function_ad0a791562fc8bfd() {
  foreach(player in level.players) {
    objweapon = player getcurrentprimaryweapon();

    if(issharedfuncdefined("zombie", "get_pap_level")) {
      n_pap_level = player function_af5127390d3221e9(objweapon);

      if(n_pap_level >= 3) {
        return true;
      }
    }
  }

  return false;
}