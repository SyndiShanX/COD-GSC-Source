/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\killstreak.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace killstreak;

function hasplayerdiedwhileusingkillstreak(streakinfo) {
  return streakinfo.lifeid != getcurrentplayerlifeidforkillstreak();
}

function addtoactivekillstreaklist(streakname, threatbiasgroup, owner, outline, teamheadicon, var_81dbfc1d134bf264, endnotifyoverride) {
  assertex(isDefined(streakname), "<dev string:x1c>");
  entnumber = self getentitynumber();
  self.activeid = owner getactivekillstreakid();

  if(isDefined(streakname)) {
    if(isremotekillstreak(streakname)) {
      addtoremotekillstreaklist(entnumber);
      thread removefromremotekillstreaklistondeath(entnumber);
    }

    if(isuavkillstreak(streakname)) {
      addtouavlist(entnumber);
      thread removefromuavlistondeath(entnumber);
    } else if(isairstrikekillstreak(streakname)) {
      addtoairstrikelist(entnumber);
      thread removefromairstrikelistondeath(entnumber);
    } else if(islittlebirdkillstreak(streakname)) {
      addtolittlebirdlist(entnumber);
      thread removefromlittlebirdlistondeath(entnumber);
    } else if(ishelikillstreak(streakname)) {
      addtohelilist(entnumber);
      thread removefromhelilistondeath(entnumber);
    } else if(isturretkillstreak(streakname)) {
      addtoturretlist(entnumber);
      thread removefromturretlistondeathorcarry(entnumber);
    } else if(function_26ab4629dc655c14(streakname)) {
      function_f0edb803c309d596(entnumber);
      thread function_d3d9181348d12d5b(entnumber);
    } else if(isprojectilekillstreak(streakname)) {
      addtoprojectilelist(entnumber);
      thread removefromprojectilelistondeath(entnumber);
    } else if(issupportdronekillstreak(streakname)) {
      addtosupportdronelist(entnumber);
      thread removefromsupportdronelistondeath(entnumber);
    } else if(isassaultdronekillstreak(streakname)) {
      addtoassaultdronelist(entnumber);
      thread removefromassaultdronelistondeath(entnumber);
    } else {
      addtoplayerkillstreaklist(entnumber);
      thread removefromplayerkillstreaklistondeath(entnumber);
    }

    if(iskillstreaklockonable(streakname)) {
      self.affectedbylockon = 1;
    }
  }

  level.activekillstreaks[entnumber] = self;
  level.activekillstreaks[entnumber].streakname = streakname;

  if(threatbiasgroup == "Killstreak_Air") {
    self.isairkillstreak = 1;

    if(!isDefined(streakname) || streakname != "directional_uav") {
      self enableplayermarks("air_killstreak");
    }
  } else {
    self.isairkillstreak = 0;
    self enableplayermarks("killstreak");
  }

  if(level.teambased) {
    self filteroutplayermarks(owner.team);
  } else {
    self filteroutplayermarks(owner);
  }

  if(istrue(outline)) {
    outlineid = undefined;
    var_4e96765e8fd41c3d = undefined;

    if(level.teambased) {
      if(isridekillstreak(streakname)) {
        foreach(player in level.players) {
          if(player.team == self.team && player != self.owner) {
            outlineid = outlineenableforplayer(self, player, "outline_nodepth_cyan", "lowest");
          }

          if(isDefined(outlineid)) {
            thread removeoutlineonnotify(outlineid, endnotifyoverride);
          }
        }

        var_4e96765e8fd41c3d = 1;
      } else {
        outlineid = outlineenableforteam(self, owner.team, "outline_nodepth_cyan", "lowest");
      }
    } else {
      outlineid = outlineenableforplayer(self, owner, "outline_nodepth_cyan", "lowest");
    }

    if(!istrue(var_4e96765e8fd41c3d)) {
      thread removeoutlineonnotify(outlineid, endnotifyoverride);
    }
  }

  if(istrue(teamheadicon)) {
    assertex(isDefined(var_81dbfc1d134bf264), "<dev string:x61>");
    ownerinvisible = 0;

    if(owner isusingremote()) {
      ownerinvisible = 1;
    }

    icon = undefined;

    if(level.teambased) {
      icon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_81dbfc1d134bf264, 1, 10000, undefined, undefined, 1, ownerinvisible);
    } else {
      if(istrue(ownerinvisible)) {
        return;
      }

      icon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(owner, "hud_icon_head_equipment_friendly", var_81dbfc1d134bf264, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(icon, endnotifyoverride);
  }

  thread function_dab24dca3ba6294a(streakname);
}

function getactivekillstreakid() {
  if(!isDefined(self.pers["nextActiveID"])) {
    self.pers["nextActiveID"] = 0;
  }

  killstreakid = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return killstreakid;
}

function removeoutlineonnotify(outlineid, endnotifyoverride) {
  wait_array = ["death"];

  if(isDefined(endnotifyoverride)) {
    wait_array[wait_array.size] = endnotifyoverride;
  }

  waittill_any_in_array_return_no_endon_death(wait_array);
  outlinedisable(outlineid, self);
}

function removeteamheadicononnotify(icon, endnotifyoverride) {
  wait_array = ["death"];

  if(isDefined(endnotifyoverride)) {
    wait_array[wait_array.size] = endnotifyoverride;
  }

  waittill_any_in_array_return_no_endon_death(wait_array);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
}

function removefromactivekillstreaklist(entnumber) {
  level.activekillstreaks[entnumber] = undefined;
}

function activekillstreaklistcontains(entnumber) {
  if(!isDefined(level.activekillstreaks)) {
    return false;
  }

  return isDefined(level.activekillstreaks[entnumber]);
}

function addtoremotekillstreaklist(entnumber) {
  if(!isDefined(level.remotekillstreaks)) {
    level.remotekillstreaks = [];
  }

  level.remotekillstreaks[entnumber] = self;
}

function removefromremotekillstreaklistondeath(entnumber) {
  self waittill("death");
  level.remotekillstreaks[entnumber] = undefined;
}

function addtouavlist(entnumber) {
  if(!isDefined(level.uavmodels)) {
    level.uavmodels = [];
  }

  if(level.teambased) {
    if(!isDefined(level.uavmodels[self.team])) {
      level.uavmodels[self.team] = [];
    }

    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

function removefromuavlistondeath(entnumber) {
  self waittill("death");

  if(isDefined(self.uavrig)) {
    self.uavrig delete();
  }

  if(level.teambased) {
    team = self.team;
    level.uavmodels[team] = array_removeundefined(level.uavmodels[team]);
  } else {
    level.uavmodels = array_removeundefined(level.uavmodels);
  }

  if(isDefined(self)) {
    self delete();
  }

  removefromactivekillstreaklist(entnumber);
}

function addtoairstrikelist(entnumber) {
  if(!isDefined(level.airstrikemodels)) {
    level.airstrikemodels = [];
  }

  level.airstrikemodels[entnumber] = self;
}

function removefromairstrikelistondeath(entnumber) {
  self waittill("death");
  level.airstrikemodels[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtolittlebirdlist(entnumber) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[entnumber] = self;
}

function removefromlittlebirdlistondeath(entnumber) {
  self waittill("death");
  level.littlebirds[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtohelilist(entnumber) {
  if(!isDefined(level.helis)) {
    level.helis = [];
  }

  level.helis[entnumber] = self;
}

function removefromhelilist(entnumber) {
  level.helis[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function removefromhelilistondeath(entnumber) {
  self waittill("death");
  level.helis[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtoturretlist(entnumber) {
  if(!isDefined(level.turrets)) {
    level.turrets = [];
  }

  level.turrets[entnumber] = self;
}

function removefromturretlistondeathorcarry(entnumber) {
  waittill_any_2("death", "carried");
  level.turrets[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function function_f0edb803c309d596(entnumber) {
  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  level.mines[entnumber] = self;
}

function function_d3d9181348d12d5b(entnumber) {
  self waittill("death");
  level.mines[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtosupportdronelist(entnumber) {
  if(!isDefined(level.supportdrones)) {
    level.supportdrones = [];
  }

  level.supportdrones[entnumber] = self;
}

function removefromsupportdronelistondeath(entnumber) {
  self waittill("death");
  level.supportdrones[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtoassaultdronelist(entnumber) {
  if(!isDefined(level.assaultdrones)) {
    level.assaultdrones = [];
  }

  level.assaultdrones[entnumber] = self;
}

function removefromassaultdronelistondeath(entnumber) {
  self waittill("death");
  level.assaultdrones[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtoprojectilelist(entnumber) {
  if(!isDefined(level.projectilekillstreaks)) {
    level.projectilekillstreaks = [];
  }

  self.isprojectilekillstreak = 1;
  level.projectilekillstreaks[entnumber] = self;
}

function removefromprojectilelistondeath(entnumber) {
  self waittill("death");
  level.projectilekillstreaks[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function addtoplayerkillstreaklist(entnumber) {
  if(!isDefined(level.playerkillstreaks)) {
    level.playerkillstreaks = [];
  }

  level.playerkillstreaks[entnumber] = self;
}

function removefromplayerkillstreaklistondeath(entnumber) {
  self waittill("death");
  level.playerkillstreaks[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

function setkillstreakcontrolpriority(owner, hintstring, hintdisplayfov, var_a68f5a8aed5a3de, hintrange, userange, usepriority, var_a4c898ca05df4d4c, hinticon) {
  self makeusable();

  if(isDefined(hinticon)) {
    self setCursorHint("HINT_BUTTON");
    self sethinticon(hinticon);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethintonobstruction("show");
  self setHintString(hintstring);
  self sethintdisplayfov(hintdisplayfov);
  self setusefov(var_a68f5a8aed5a3de);
  self sethintdisplayrange(hintrange);
  self setuserange(userange);
  self setuseholdduration("duration_short");

  if(!isDefined(usepriority)) {
    usepriority = -1;
  }

  self setusepriority(usepriority);
  level thread applyplayercontrolonconnect(self);

  foreach(player in level.players) {
    if(player == owner && !istrue(var_a4c898ca05df4d4c)) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

function applyplayercontrolonconnect(killstreakuseent) {
  killstreakuseent endon("death");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    killstreakuseent disableplayeruse(player);
  }
}

function applykillstreakplayeroutline(player, streakendnotify) {
  assertex(isDefined(self.owner), "<dev string:x96>");
  assertex(isDefined(self.team), "<dev string:xd3>");
  killstreakteam = self.team;
  killstreakowner = self.owner;
  hudoutlineasset = undefined;
  perkcheck = undefined;

  if(!player scripts\cp_mp\utility\player_utility::_isalive() || player.team == "spectator" || player.team == "codcaster") {
    return;
  }

  if(player == killstreakowner) {
    hudoutlineasset = "outlinefill_depth_cyan";
  } else if(player != killstreakowner) {
    if(level.teambased && player.team != killstreakteam || !level.teambased) {
      hudoutlineasset = "outlinefill_depth_orange";
      perkcheck = 1;
    } else {
      return;
    }
  }

  if(isDefined(hudoutlineasset)) {
    if(istrue(perkcheck)) {
      if(player _hasperk("specialty_noplayertarget")) {
        return;
      }
    }

    id = outlineenableforplayer(player, self.owner, hudoutlineasset, "killstreak");
    thread watchoutlineremoveonkillstreakend(id, player, streakendnotify);
    thread watchoutlineremoveonplayerend(id, player, streakendnotify);
  }
}

function watchoutlineremoveonkillstreakend(id, player, streakendnotify) {
  player endon("death_or_disconnect");
  level endon("game_ended");
  self waittill(streakendnotify);
  outlinedisable(id, player);
}

function watchoutlineremoveonplayerend(id, player, streakendnotify) {
  self endon(streakendnotify);
  level endon("game_ended");
  player waittill("death_or_disconnect");
  outlinedisable(id, player);
}

function function_394de31762a977eb(weaponname, damagesize) {
  assert(damagesize == #"oneshot" || damagesize == #"large" || damagesize == #"medium" || damagesize == #"low" || damagesize == #"tick" || damagesize == #"hash_b76b2215370d2700");

  if(damagesize == #"hash_b76b2215370d2700") {
    return;
  }

  level.var_c6411e8929fa12b3[weaponname] = damagesize;
}

function getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride) {
  var_f20bc25347c9baaf = 0;
  var_4d8dc8aa1757e7a9 = 0;

  if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case #"hash_4fb186ef47273ade":
      case #"hash_5f1054c48d66fd1c":
      case #"hash_966768b3f0c94767":
        break;
      case #"hash_3c20f39c73a1422b":
      case #"hash_571e46e17a3cf2e3":
      case #"hash_66cb246f3e55fbe2":
      case #"hash_a5123f4d02745600":
      case #"hash_a86d8c43482948a4":
      case #"hash_a911a1880d996edb":
      case #"hash_c22b13f81bed11f0":
      case #"hash_d8646db4e6ee3658":
        var_4d8dc8aa1757e7a9 = 1;
        break;
      default:
        break;
    }
  }

  if(var_4d8dc8aa1757e7a9) {
    divisor = undefined;

    if(meansofdeath != "MOD_MELEE") {
      damagesize = undefined;

      if(isDefined(level.var_c6411e8929fa12b3) && isDefined(objweapon)) {
        damagesize = level.var_c6411e8929fa12b3[objweapon.basename];
      }

      if(!isDefined(damagesize) && isDefined(objweapon)) {
        switch (objweapon.basename) {
          case #"hash_48cc3a9a58208f82":
          case #"hash_85ea99fcbe4116a4":
          case #"hash_aae52fc2913829d0":
            damagesize = #"oneshot";
            break;
          case #"hash_1fa9e128f4c7b140":
          case #"hash_f55c20924061bd15":
          case #"hash_6b9700922cc910a9":
          case #"hash_cb6c35c79573eb64":
          case #"hash_13a265ac820ea0df":
          case #"hash_e704ecf8710c6f57":
          case #"hash_1a8f43f197f508a0":
          case #"hash_a54e19ae2e8d865c":
          case #"hash_4f9064f9a7a4b7d1":
          case #"hash_1d6b88bde28b109a":
          case #"hash_7917bb9ef2886e20":
          case #"hash_c5c19fe9ae40cd0c":
          case #"hash_fe08358bc8f9a34a":
          case #"hash_24936ab5bf8a0e20":
          case #"hash_5c272c0617caebf0":
          case #"hash_5cbb3a1a84d47f1d":
          case #"hash_c124ad09158500e9":
          case #"hash_5e8f81314553dd36":
          case #"hash_2f1a9d8e2f127205":
          case #"hash_7a687f6a4d685110":
          case #"hash_7de9687a97e62d93":
          case #"hash_3532a220183691a5":
          case #"hash_3e782fd775b72022":
          case #"hash_a9e31b8ffd42a67b":
            damagesize = #"large";
            break;
          case #"hash_79ee9dd492804fa":
          case #"hash_996455d7b14b362":
          case #"hash_fbca161190fca27d":
          case #"hash_12a2863ecf2eeecd":
          case #"hash_fc4c0a8ee31549bb":
          case #"hash_fd76dc693da26245":
          case #"hash_1ba6982534c8d1d6":
          case #"hash_1cb3f2dbe85b8540":
          case #"hash_fd79e0693da4a728":
          case #"hash_1ee2bbd1bc80ea9a":
          case #"hash_254b6e155434f84d":
          case #"hash_259ae6e25d936c3e":
          case #"hash_25fc06d658620968":
          case #"hash_2654d1bcc59b62b6":
          case #"hash_3226ebed78234b14":
          case #"hash_33aef56fb95396fd":
          case #"hash_359ac460bda5f9b8":
          case #"hash_3f2944fd91792508":
          case #"hash_471c36daeb2a655a":
          case #"hash_4e213f6d3f76b400":
          case #"hash_4fd5d83c1a7f06a7":
          case #"hash_51f4f5345b01f136":
          case #"hash_62a9688b69906271":
          case #"hash_aef479d2af969a2d":
          case #"hash_6ac8f418ee829465":
          case #"hash_708fb6e22f87a3a4":
          case #"hash_73b4956c8f4b5217":
          case #"hash_82a5b9368f3f35ae":
          case #"hash_892911bfe6164871":
          case #"hash_78ee9dd491b3907":
          case #"hash_91a48ebfd2d03a40":
          case #"hash_9386cafe3d8d6d59":
          case #"hash_9f73f49d822d9acc":
          case #"hash_a0bfc30978e56904":
          case #"hash_a622e958420b92a0":
          case #"hash_a9e5050965551dca":
          case #"hash_acaf314732f4c8e4":
          case #"hash_af540b603005b109":
          case #"hash_af7c176030248498":
          case #"hash_b1d4d0d68c2b0c0f":
          case #"hash_b4fb660fd7773831":
          case #"hash_bac656916e53b91c":
          case #"hash_badacfdae124cc01":
          case #"hash_c6ea1214797e3ea1":
          case #"hash_cd6b1f03c24c25ff":
          case #"hash_cf8515f17748a7d2":
          case #"hash_d1ffad9819388638":
          case #"hash_d30fa952a74e1642":
          case #"hash_d4532f8e0fa86548":
          case #"hash_d7f368cf53337cfd":
          case #"hash_e7af9caef1aa7899":
          case #"hash_e9ee40174ddfa406":
          case #"hash_ec580a77ee20c7bd":
          case #"hash_edf51f8e5118b630":
          case #"hash_ee243b8e513db31d":
          case #"hash_f003a3dc14dbdf3f":
          case #"hash_f5f81c45da642380":
          case #"hash_f816d2efb1dcbed0":
            damagesize = #"medium";
            break;
          case #"hash_17c70dc48424ba92":
          case #"hash_1a9da8a4fac9fde4":
          case #"hash_1e6ad4ef0904a0f1":
          case #"hash_d30bcd7e470500f3":
          case #"hash_996849dc6e47c18f":
          case #"hash_d6565ec12efca627":
          case #"hash_6a2e4f9c54756dc7":
          case #"hash_dd4d572af14a12c2":
          case #"hash_e36b3928a0e518fa":
          case #"hash_6547ec525f1340da":
          case #"hash_5e4ccaa178cac19c":
          case #"hash_c3639c6f29cf149a":
          case #"hash_c4b9b21ecac2ced4":
          case #"hash_56ee829cc162271a":
          case #"hash_435258fc47768fa7":
          case #"hash_4b87af60037f526f":
          case #"hash_cce14c95e4764532":
          case #"hash_8c12df11df01f306":
          case #"hash_a009d256608f52ce":
          case #"hash_81d0787e9a579f3c":
          case #"hash_ca48d454faafb042":
            damagesize = #"low";
            break;
          case #"hash_104394c101679f9e":
          case #"hash_b8c7008e1d8543df":
          case #"hash_d78eda24c2fd8252":
          case #"hash_a49fac234083ff01":
          case #"hash_8fd6158eb96a1f15":
          case #"hash_4c7de5619284e175":
            damagesize = #"tick";
            break;
        }
      }
    } else {
      damagesize = #"melee";
    }

    if(isDefined(damagesize)) {
      if(damagesize == #"oneshot") {
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        divisor = 1;
      } else if(damagesize == #"large") {
        self.largeprojectiledamage = 1;
        divisor = divisorlrg;
      } else if(damagesize == #"medium") {
        self.largeprojectiledamage = 1;
        divisor = divisormed;
      } else if(damagesize == #"low") {
        self.largeprojectiledamage = 0;
        divisor = divisorlow;
      } else if(damagesize == #"tick") {
        self.largeprojectiledamage = 0;
        divisor = divisortick;
      } else if(damagesize == #"melee") {
        self.largeprojectiledamage = 0;
        divisor = divisormelee;
      }
    }

    if(isDefined(divisor)) {
      amount = ceil(maxhealth / divisor);
      var_f20bc25347c9baaf = 1;
    }
  }

  if(isDefined(explodeoverride)) {
    self.largeprojectiledamage = explodeoverride;
  }

  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(!var_f20bc25347c9baaf && isDefined(objweapon)) {
    amount = scripts\mp\damage::handleshotgundamage(objweapon, meansofdeath, amount);
    amount = scripts\mp\damage::handleapdamage(objweapon, meansofdeath, amount, attacker);
    amount = scripts\mp\damage::function_5e4aa8d548cc604e(amount, objweapon, attacker, meansofdeath);
    amount = scripts\mp\damage::function_10268164ab1bcc31(amount, objweapon, attacker);
  }

  if(isDefined(attacker) && isDefined(self.owner) && !var_e688b198aa9a4b3f) {
    if(isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(attacker == self.owner && !istrue(self.killoneshot)) {
      amount = ceil(amount / 2);
    }
  }

  return int(amount);
}

function nulldamagecheck(attacker) {
  return isDefined(attacker) && attacker == self.owner;
}

function dodamagetokillstreak(damage, attacker, inflictor, victimteam, sourceorigin, meansofdeath, weaponname) {
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  angles = (0, 0, 0);
  normal = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  idflags = undefined;

  if(isDefined(victimteam)) {
    if(level.teambased) {
      if(!isvalidteamtarget(attacker, victimteam, self)) {
        return;
      }
    } else if(!isvalidffatarget(attacker, victimteam, self)) {
      return;
    }
  }

  if(isagent(self)) {
    self dodamage(damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname);
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    self dodamage(damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname);
    return;
  }

  weapon = makeweaponfromstring(weaponname);
  self notify("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, sourceorigin, angles, normal, inflictor);
}

function playdlightfx(posoffset, angleoffset) {
  self endon("death");

  if(!isDefined(posoffset)) {
    posoffset = (0, 0, 0);
  }

  if(!isDefined(angleoffset)) {
    angleoffset = (0, 0, 0);
  }

  dlightfx = getfx("dlight_large");

  if(istrue(self.isairdrop)) {
    dlightfx = getfx("dlight_small");
  }

  self.fxdlightent = spawn("script_model", self.origin);
  self.fxdlightent setModel("tag_origin");
  self.fxdlightent linkTo(self, "tag_origin", posoffset, angleoffset);
  self.fxdlightent thread deleteonparentdeath(self);
  wait 0.1;
  playFXOnTag(dlightfx, self.fxdlightent, "tag_origin");
}

function deleteonparentdeath(parent) {
  self endon("death");
  parent waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

function isaffectedbyblindeye(killstreakname) {
  switch (killstreakname) {
    case #"hash_576b868dbf9eab17":
    case #"hash_8b0d967838e55b97":
      return true;
  }

  return false;
}

function watchsupertrophynotify(owner) {
  owner endon("disconnect");
  self endon("explode");

  while(true) {
    owner waittill("destroyed_by_trophy", trophyowner, trophyweaponname, targetweaponname, targetorigin, targetangles);

    if(targetweaponname != self.weapon_name) {
      continue;
    }

    owner updatedamagefeedback("");
    break;
  }
}

function watchhostmigrationlifetime(var_5303201f58dbbafe, lifetime, lifetimefunc) {
  if(var_5303201f58dbbafe != "death") {
    self endon("death");
  }

  self endon(var_5303201f58dbbafe);
  level endon("game_ended");
  startinglifetime = gettime() + int(lifetime * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  hoststarttime = gettime();
  remaininglifetime = startinglifetime - hoststarttime;
  level waittill("host_migration_end");
  hostendtime = gettime();
  newtime = hostendtime + remaininglifetime;
  remaininglifetime /= 1000;

  if(isDefined(self.streakname) && isridekillstreak(self.streakname)) {
    self.owner setclientomnvar("ui_killstreak_countdown", newtime);
  }

  self[[lifetimefunc]](remaininglifetime);
}

function getenemytargets(owner) {
  enemytargets = [];

  foreach(player in level.players) {
    if(owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
      enemytargets[enemytargets.size] = player;
    }
  }

  return enemytargets;
}

function _beginlocationselection(streakname, selectortype, directionality, size) {
  self beginlocationselection(selectortype, directionality, "circle_marker", size);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("cancel_location");
  thread endselectiononaction("death");
  thread endselectiononaction("disconnect");
  thread endselectiononaction("used");
  thread endselectiononaction("weapon_change");
  self endon("stop_location_selection");
  thread endselectiononendgame();

  if(isDefined(streakname) && self.team != "spectator" && self.team != "codcaster") {
    if(isDefined(self.streakmsg)) {
      self.streakmsg destroy();
    }

    if(self issplitscreenplayer()) {
      self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.3);
      self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
      return;
    }

    self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.6);
    self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
  }
}

function stoplocationselection(disconnected, reason) {
  if(!isDefined(reason)) {
    reason = "generic";
  }

  if(!disconnected) {
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self.selectinglocation = undefined;

    if(isDefined(self.streakmsg)) {
      self.streakmsg destroy();
    }
  }

  self notify("stop_location_selection", reason);
}

function endselectiononaction(waitfor) {
  self endon("stop_location_selection");
  self waittill(waitfor);
  thread stoplocationselection(waitfor == "disconnect", waitfor);
}

function endselectiononendgame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread stoplocationselection(0, "end_game");
}

function streakshouldchain(streakname) {
  var_c45c5e5081953209 = scripts\mp\killstreaks\killstreaks::calcstreakcost(streakname);
  nextstreakname = scripts\mp\killstreaks\killstreaks::getnextstreakname();
  nextstreakcost = scripts\mp\killstreaks\killstreaks::calcstreakcost(nextstreakname);
  return var_c45c5e5081953209 < nextstreakcost;
}

function streakcheckistargetindoors(targetpos, ignorelist) {
  isindoors = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(targetpos, targetpos + (0, 0, 10000), ignorelist, contents)) {
    isindoors = 1;
  }

  return isindoors;
}

function function_26ab4629dc655c14(streakname) {
  var_26ab4629dc655c14 = 0;

  switch (streakname) {
    case #"hash_472d8b6c2f51a9c8":
    case #"hash_4d35eb58f9d545f0":
      var_26ab4629dc655c14 = 1;
      break;
  }

  return var_26ab4629dc655c14;
}

function isremotekillstreak(streakname) {
  remotekillstreak = 0;

  switch (streakname) {
    case #"hash_28d0236400e33fd0":
    case #"hash_349713b5ad494dda":
    case #"hash_413c38e72fe8b5bf":
    case #"hash_9e36e3bd3a9dd00d":
    case #"hash_cf0ef5bef19a311b":
      remotekillstreak = 1;
      break;
  }

  return remotekillstreak;
}

function isuavkillstreak(streakname) {
  isuav = 0;

  switch (streakname) {
    case #"hash_10e585c25e7e9f60":
    case #"hash_634b246c3da5c56f":
    case #"hash_e171e5b86ef0a4cc":
    case #"hash_e51f2e3d5cdd8ed8":
      isuav = 1;
      break;
  }

  return isuav;
}

function isairstrikekillstreak(streakname) {
  var_cc5e6f089d31a891 = 0;

  switch (streakname) {
    case #"hash_195360490caa3220":
    case #"hash_413c38e72fe8b5bf":
    case #"hash_4220be38a5f150b8":
    case #"hash_62810d05099e0103":
    case #"hash_7a687f6a4d685110":
    case #"hash_8c766d6477287bb6":
    case #"hash_a1031216158c7882":
    case #"hash_b161e185f1b8e117":
      var_cc5e6f089d31a891 = 1;
      break;
  }

  return var_cc5e6f089d31a891;
}

function islittlebirdkillstreak(streakname) {
  islittlebird = 0;

  switch (streakname) {
    case #"hash_2289ec11d77bce8f":
    case #"hash_56979e0566996b2e":
      islittlebird = 1;
      break;
  }

  return islittlebird;
}

function ishelikillstreak(streakname) {
  isheli = 0;

  switch (streakname) {
    case #"hash_bf2f9adbd2b41d5":
    case #"hash_349713b5ad494dda":
    case #"hash_887ad77192b9c4fb":
      isheli = 1;
      break;
  }

  return isheli;
}

function isturretkillstreak(streakname) {
  isturret = 0;

  switch (streakname) {
    case #"hash_19dd9a3a4147e09e":
    case #"hash_4d5aa76e8707f47b":
    case #"hash_52d9b7ed584bec3e":
      isturret = 1;
      break;
  }

  return isturret;
}

function isprojectilekillstreak(streakname) {
  isprojectile = 0;

  switch (streakname) {
    case #"hash_28d0236400e33fd0":
    case #"hash_6362d6aae3e5a62e":
    case #"hash_7a687f6a4d685110":
    case #"hash_b4ac3581c343a029":
      isprojectile = 1;
      break;
  }

  return isprojectile;
}

function issupportdronekillstreak(streakname) {
  var_1cda07ab27d6768e = 0;

  switch (streakname) {
    case #"hash_27002778019fb447":
    case #"hash_e40585107590f016":
      var_1cda07ab27d6768e = 1;
      break;
  }

  return var_1cda07ab27d6768e;
}

function isassaultdronekillstreak(streakname) {
  isassaultdrone = 0;

  switch (streakname) {
    case #"hash_9e36e3bd3a9dd00d":
    case #"hash_cf0ef5bef19a311b":
      isassaultdrone = 1;
      break;
  }

  return isassaultdrone;
}

function iscarepackage(ent) {
  return isDefined(ent) && isDefined(ent.id) && ent.id == "care_package";
}

function isjuggernaut() {
  return isDefined(self) && istrue(self.isjuggernaut);
}

function isremotekillstreakweapon(weapon) {
  remoteweapon = 0;

  switch (weapon) {
    case #"hash_32eb6c9e8b2bae4a":
    case #"hash_33c7f389fa9d6dd5":
    case #"hash_42f1955f763af384":
    case #"hash_45e409945333f912":
    case #"hash_5f2ad7140f378ee1":
    case #"hash_70c33644073da94f":
    case #"hash_b43c2e4c05fafc4b":
    case #"hash_f194befae42e3476":
      remoteweapon = 1;
      break;
  }

  return remoteweapon;
}

function iskillstreaklockonable(streakname) {
  switch (streakname) {
    case #"hash_28d0236400e33fd0":
    case #"hash_56979e0566996b2e":
    case #"hash_e171e5b86ef0a4cc":
      return 0;
    default:
      return 1;
  }
}

function isflyingkillstreak(streakname) {
  switch (streakname) {
    case #"hash_13353c75b92b3fcc":
    case #"hash_26a12ee6db5cd83c":
    case #"hash_2916b409ed596650":
    case #"hash_413c38e72fe8b5bf":
    case #"hash_56979e0566996b2e":
    case #"hash_8c766d6477287bb6":
    case #"hash_d5cb9b4efa4e54b6":
    case #"hash_ea61c6ba128ead64":
      return 1;
    default:
      return 0;
  }
}

function getkillstreakkills(streakname) {
  bundle = level.streakglobals.streakbundles[streakname];

  if(!isDefined(bundle)) {
    return 0;
  }

  cost = bundle.kills;

  if(_hasperk("specialty_killstreak_to_scorestreak") && streakname != "nuke" && streakname != "dna_nuke") {
    cost = bundle.scorecost;
  } else if(_hasperk("specialty_support_killstreaks")) {
    cost = bundle.supportcost;
  }

  cost = function_545766e9ea1f655d(streakname, cost);
  return ter_op(isDefined(cost), cost, 0);
}

function function_545766e9ea1f655d(streakname, cost) {
  if(isDefined(self.var_f3c2f1677bc581d7) && isDefined(self.var_f3c2f1677bc581d7[streakname])) {
    foreach(value in self.var_f3c2f1677bc581d7[streakname].values) {
      if(value < cost) {
        cost = value;
      }
    }
  }

  return cost;
}

function getkillstreakoverheadicon(streakname) {
  bundle = level.streakglobals.streakbundles[streakname];

  if(!isDefined(bundle)) {
    return "";
  }

  return ter_op(isDefined(bundle.overheadicon), bundle.overheadicon, "");
}

function function_8728f7cf8c005a0(streakname) {
  bundle = level.streakglobals.streakbundles[streakname];

  if(!isDefined(bundle)) {
    return false;
  }

  return istrue(bundle.var_70bf491b5574dfcc);
}

function currentactivevehiclecount(extra) {
  if(!isDefined(extra)) {
    extra = 0;
  }

  count = extra;

  if(isDefined(level.helis)) {
    count += level.helis.size;
  }

  if(isDefined(level.littlebirds)) {
    count += level.littlebirds.size;
  }

  if(isDefined(level.ugvs)) {
    count += level.ugvs.size;
  }

  if(isDefined(level.bradley) && isDefined(level.bradley.vehicles)) {
    count += level.bradley.size;
  }

  if(isDefined(level.supportdrones)) {
    count += level.supportdrones.size;
  }

  if(isDefined(level.assaultdrones)) {
    count += level.assaultdrones.size;
  }

  return count;
}

function maxvehiclesallowed() {
  return 8;
}

function fauxvehiclecount() {
  return level.fauxvehiclecount;
}

function incrementfauxvehiclecount(value) {
  if(!isDefined(value)) {
    level.fauxvehiclecount++;
    return;
  }

  level.fauxvehiclecount += value;
}

function decrementfauxvehiclecount(value) {
  if(!isDefined(value)) {
    level.fauxvehiclecount--;
  } else {
    level.fauxvehiclecount -= value;
  }

  if(level.fauxvehiclecount < 0) {
    level.fauxvehiclecount = 0;
  }
}

function isassaultkillstreak(refstring) {
  switch (refstring) {
    case #"hash_26a12ee6db5cd83c":
    case #"hash_634b246c3da5c56f":
    case #"hash_e171e5b86ef0a4cc":
      return 1;
    default:
      return 0;
  }
}

function isresourcekillstreak(refstring) {
  switch (refstring) {
    case #"hash_155f01fe111e3395":
    case #"hash_283643e4f79541f8":
    case #"hash_36653f7e35d0878d":
    case #"hash_6969314db2c192ea":
    case #"hash_c244f66a067b8deb":
    case #"hash_c72f9e2dc5fac20b":
      return 1;
    default:
      return 0;
  }
}

function issupportkillstreak(refstring) {
  return false;
}

function isspecialistkillstreak(refstring) {
  return false;
}

function gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

function gethelipilottraceoffset() {
  return (0, 0, 2500);
}

function isnavmeshkillstreak(streakname) {
  requiresnavmesh = 0;
  return requiresnavmesh;
}

function iscontrollingproxyagent() {
  if(isDefined(self.playerproxyagent) && isalive(self.playerproxyagent)) {
    return true;
  }

  return false;
}

function killshouldaddtokillstreak(objweapon) {
  if(_hasperk("specialty_explosivebullets")) {
    return false;
  }

  return !scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename) && scripts\mp\utility\points::function_caddf81c02734fa0(objweapon);
}

function getairdropcrates() {
  if(isDefined(level.cratedata)) {
    return level.cratedata.crates;
  }

  return [];
}

function getnumairdropcrates() {
  if(isDefined(level.cratedata)) {
    return level.cratedata.crates.size;
  }

  return 0;
}

function attackerinremotekillstreak() {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(level.gunshipplayer) && self == level.gunshipplayer) {
    return true;
  }

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner) {
    return true;
  }

  if(isDefined(self.using_remote_tank) && self.using_remote_tank) {
    return true;
  }

  return false;
}

function killstreak_make_vehicle(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.vehiclename = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
  self enableplayermarks("killstreak");

  if(level.teambased) {
    self filteroutplayermarks(self.team);
  } else {
    self filteroutplayermarks(self.owner);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(streakname, 1);
}

function killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = &killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = &killstreak_post_mod_damage_callback;
    level.ksdeathcallback = &killstreak_death_callback;
  }
}

function killstreak_pre_mod_damage_callback(data) {
  damage = data.damage;
  attacker = data.attacker;

  if(!istrue(self.killoneshot) && !istrue(self.debugdamage)) {
    if(isDefined(attacker) && isDefined(self.owner) && attacker == self.owner) {
      damage = int(ceil(damage * 0.5));
    }

    data.damage = damage;
  }

  if(isDefined(attacker) && attacker isspawnprotected()) {
    attacker clearspawnprotection();
  }

  shouldcontinue = 1;
  premoddamagecallback = self.kspremoddamagecallback;

  if(isDefined(premoddamagecallback)) {
    shouldcontinue = self[[premoddamagecallback]](data);
  }

  return shouldcontinue;
}

function killstreak_post_mod_damage_callback(data) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(data.attacker, data.objweapon, self, data.meansofdeath, data.damage);
  shouldcontinue = 1;
  postmoddamagecallback = self.kspostmoddamagecallback;

  if(isDefined(postmoddamagecallback)) {
    shouldcontinue = self[[postmoddamagecallback]](data);
  }

  return shouldcontinue;
}

function killstreak_death_callback(data) {
  scripts\mp\damage::onkillstreakkilled(self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  shouldcontinue = 1;
  deathcallback = self.ksdeathcallback;

  if(isDefined(deathcallback)) {
    shouldcontinue = self[[deathcallback]](data);
  }

  return shouldcontinue;
}

function killstreak_set_pre_mod_damage_callback(streakname, premoddamagecallback) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(streakname, level.kspremoddamagecallback);
  self.kspremoddamagecallback = premoddamagecallback;
}

function killstreak_set_post_mod_damage_callback(streakname, postmoddamagecallback) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(streakname, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = postmoddamagecallback;
}

function killstreak_set_death_callback(streakname, deathcallback) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_death_callback(streakname, level.ksdeathcallback);
  self.ksdeathcallback = deathcallback;
}

function getkillstreaknamefromweapon(objweapon) {
  basename = objweapon.basename;

  if(isDefined(level.killstreakweaponmap[basename])) {
    return level.killstreakweaponmap[basename];
  }

  return undefined;
}

function function_dab24dca3ba6294a(streakname) {
  level endon("<dev string:x10f>");
  devdvar = @ "hash_b4fe29a00bfde823";
  setdevdvarifuninitialized(devdvar, 0);

  while(isDefined(self)) {
    debugdamage = getdvarint(devdvar, 0);

    if(!debugdamage) {
      if(istrue(self.debugdamage)) {
        self.debugdamage = undefined;
      }

      waitframe();
      continue;
    }

    self.debugdamage = 1;
    damageamount = 0;
    damagemod = "<dev string:x11d>";
    debugweapon = "<dev string:x12e>";

    switch (debugdamage) {
      case 1:
        damageamount = int(self.maxhealth * 0.25);
        break;
      case 2:
        damageamount = int(self.maxhealth * 0.5);
        break;
      case 3:
        damageamount = int(self.maxhealth * 0.75);
        break;
      case 4:
        damageamount = self.maxhealth;
        damagemod = "<dev string:x142>";
        debugweapon = "<dev string:x156>";
        break;
      case 5:
        damageamount = self.maxhealth;
        break;
    }

    self dodamage(damageamount, self.origin, self.owner, self.owner, damagemod, makeweapon(debugweapon));
    waitframe();
    setDvar(devdvar, 0);
  }
}

# /