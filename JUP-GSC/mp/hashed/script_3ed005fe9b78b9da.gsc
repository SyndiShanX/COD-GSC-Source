/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ed005fe9b78b9da.gsc
*************************************************/

#using script_22b5518d4dea99e0;
#using script_2378a2f0d44180ab;
#using script_33b83540dd41c31e;
#using script_39ae84cf3eeebf70;
#using script_3e407bc1a2cb914a;
#using script_62df8493dd83fb28;
#using script_7ea8d5131099fb0c;
#using script_7f6ad64bfc1e2f89;
#using script_bcf73325fb07789;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\weapon;
#namespace namespace_9beba625007983e5;

function setupzombiepowers() {
  level.var_ec4da42b3bbf344c.var_9361e1a27424b099 = [];
  level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default1"] = spawnStruct();
  level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default4"] = spawnStruct();
  level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default3"] = spawnStruct();
  level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default2"] = spawnStruct();

  foreach(struct in level.var_ec4da42b3bbf344c.var_9361e1a27424b099) {
    struct.powers = [];
  }

  setdvarifuninitialized(@ "hash_1003a1525408b1fb", 7);
  setdvarifuninitialized(@ "hash_27e50976961fc819", 20);
  setdvarifuninitialized(@ "hash_341483558fb0f08f", 20);
  setdvarifuninitialized(@ "hash_61b61f0247cb96ea", 5);
  setdvarifuninitialized(@ "hash_37ef7e0a0085a948", 100);
  setdvarifuninitialized(@ "hash_bd303228300d36d7", 715);
  setdvarifuninitialized(@ "hash_8b44cc18eb0e9546", 7);
  setdvarifuninitialized(@ "hash_859e9c7c3ac9260c", 12);
  setdvarifuninitialized(@ "hash_5941ed16e612ecd7", 25);
  setdvarifuninitialized(@ "hash_b47864d5c052952", 10);
  setdvarifuninitialized(@ "hash_b354e314c0b6260c", 20);
  setdvarifuninitialized(@ "hash_5c585d5f44aacc5d", 10);
  setdvarifuninitialized(@ "hash_ad5c1a6a44d0a85c", 10);
  setdvarifuninitialized(@ "hash_5c6f048df99cb933", 4.5);
  setdvarifuninitialized(@ "hash_3b2d36b2285f2a11", 5.5);
  setdvarifuninitialized(@ "hash_39d77d3dc4a00ecc", 30);
  struct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default1"];
  struct namespace_e9836a64147a29e8::function_51e961150661d4b4();
  struct namespace_e5b8d54a860243e8::function_c9af900a7b02e1();
  struct namespace_a834b08ee875ee74::function_453d52eb553e1047();
  struct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default4"];
  struct namespace_79b4f5063a88552f::function_7a154baa848107ab();
  struct namespace_b73570c910c5fc65::function_2b4e536e2b50c34d();
  struct namespace_3b5097f7552b7b28::function_b2524786c57b7bc0();
  struct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default3"];
  struct namespace_670fc03d7d279b06::function_3a1cb71d78e0d1();
  struct namespace_e5b8d54a860243e8::function_227f2863eee9ec43();
  struct namespace_1729f80971fc3afb::function_ec3d5e24082874e4();
  struct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default2"];
  struct namespace_e9836a64147a29e8::function_58b5b82e9532c92b();
  struct namespace_e5b8d54a860243e8::function_71a5bfdc64379827();
  struct namespace_4d3c0289243b34f8::function_efcef5f4202ca985();
}

function initpostmain() {
  level.var_ec4da42b3bbf344c = spawnStruct();
  level.var_ec4da42b3bbf344c.zombiehealth = getdvarint(@ "hash_457a291554d55361", 350);
  level.var_ec4da42b3bbf344c.zombiesdamagezombies = getdvarint(@ "hash_7d04136e229c6d7a", 0);
  level.var_ec4da42b3bbf344c.var_8faaf289e5d10151 = getdvarint(@ "hash_8584a72dd6afa977", 80);
  level.var_ec4da42b3bbf344c.zombiesignorevehicleexplosions = getdvarint(@ "hash_9e8f30b569e2abe5", 1);
  level.var_ec4da42b3bbf344c.var_8eb8826347f1258 = getdvarint(@ "hash_3ad2f81e6e6cf99c", 1);
  level.var_ec4da42b3bbf344c.zombiepingrate = getdvarfloat(@ "hash_4dab1aaf5c7733be", -1);
  level.var_ec4da42b3bbf344c.zombiepingtime = getdvarfloat(@ "hash_35b72e2558f0a7cd", 0.5);
  level.var_ec4da42b3bbf344c.zombienumtoconsume = getdvarint(@ "hash_1322659ceb016a98", 4);
  level.var_ec4da42b3bbf344c.zombieregenratescaleingas = getdvarfloat(@ "hash_732dbd6ba0b0f252", 2);
  level.var_ec4da42b3bbf344c.zombieregenratescaleoutgas = getdvarfloat(@ "hash_dd936bdb4cf1f2ef", 0.7);
  level.var_ec4da42b3bbf344c.zombieregendelayscaleingas = getdvarfloat(@ "hash_c186667e8cb3bc6b", 1);
  level.var_ec4da42b3bbf344c.zombieregendelayscaleoutgas = getdvarfloat(@ "hash_b0687a8f2794f3b8", 1.5);
  level.var_ec4da42b3bbf344c.zombiepowersenabled = getdvarint(@ "hash_b760176b090452c1", 1);
  level.var_ec4da42b3bbf344c.powerscooldown = getdvarint(@ "hash_2546d85e9d039f6b", 1);
  level.var_ec4da42b3bbf344c.zombienumhitshuman = getdvarfloat(@ "hash_a08fd1aad589d41b", 3);
  level.var_ec4da42b3bbf344c.var_df9ba21d322f48a0 = getdvarint(@ "hash_6931def073d51e8c", 1);
  level.var_ec4da42b3bbf344c.zombienumhitsheli = getdvarfloat(@ "hash_8d24cf268d991c83", 2);
  level.var_ec4da42b3bbf344c.zombienumhitsatv = getdvarfloat(@ "hash_afb1f56ac422f668", 2);
  level.var_ec4da42b3bbf344c.zombienumhitscar = getdvarfloat(@ "hash_9162a16aad712f5b", 3);
  level.var_ec4da42b3bbf344c.zombienumhitstruck = getdvarfloat(@ "hash_5552790671b23f3e", 4);
  level.var_ec4da42b3bbf344c.zombiespawninair = getdvarint(@ "hash_9c4658bfbe5e2b39", 1);
  level.var_ec4da42b3bbf344c.zombievehiclelaststand = getdvarint(@ "hash_46634a326aa6bc5e", 0);
  level.var_ec4da42b3bbf344c.zombiespawnabovedeath = getdvarint(@ "hash_b2ccefcd02e5660f", 0);
  level.var_ec4da42b3bbf344c.humanspawninair = getdvarint(@ "hash_9ec879d1dafa798b", 1);
  level.var_ec4da42b3bbf344c.var_863f6d0e1a1c01e9 = getdvarint(@ "hash_1ee25065b4a3191c", 1);
  level.var_ec4da42b3bbf344c.hudserver = getdvarint(@ "hash_b5ac32636b6ff882", 0);
  level.var_ec4da42b3bbf344c.var_854edaec88caf865 = getdvarint(@ "hash_21fbbc29b9fecac8", 20);
  level.var_ec4da42b3bbf344c.var_854ed7ec88caf1cc = getdvarint(@ "hash_31d8c8e967f4f20f", 30);
  level.var_ec4da42b3bbf344c.zombievision = getdvarint(@ "hash_41594fbb80d9883e", 1);

  if(isDefined(level.var_678d42aa0c5f90ef)) {
    level.var_ec4da42b3bbf344c.zombievisionset = getDvar(@ "hash_23bfd5f2a84eb6d8", level.var_678d42aa0c5f90ef);
  } else {
    level.var_ec4da42b3bbf344c.zombievisionset = getDvar(@ "hash_23bfd5f2a84eb6d8", "mp_zmb_pm");
  }

  level.var_ec4da42b3bbf344c.var_63d9be743a6ba8cd = getdvarint(@ "hash_fdb01d1a58dcdcb1", 1);
  level.var_ec4da42b3bbf344c.var_f08bfc048423d1dc = getdvarint(@ "hash_8c5546e4f573664", 0);
  level.var_ec4da42b3bbf344c.var_68dfc0a151952869 = getdvarfloat(@ "hash_340b7eb839056345", 0.65);
  level.var_ec4da42b3bbf344c.var_9dd997ced889b541 = getdvarint(@ "hash_a34f4bb4586ca7a6", 1);
  level.var_ec4da42b3bbf344c.var_888a368fc494c603 = getdvarint(@ "hash_77b0c9b7f8217be6", 1);
  level.var_ec4da42b3bbf344c.var_b8456bbdf46925a3 = getdvarint(@ "hash_4903cbd81395da65", 0);
  level.var_ec4da42b3bbf344c.var_fe1ed6b37a8d2bba = getdvarint(@ "hash_ef3cf14423ea0971", 1);
  level.var_ec4da42b3bbf344c.var_52d26462081a2d41 = getdvarfloat(@ "hash_6db0c7f59c294cb4", 1);
  level.var_ec4da42b3bbf344c.var_5a945be17bf844bd = getdvarfloat(@ "hash_6715c45dd1cda5bf", 10);
  level.var_ec4da42b3bbf344c.var_89b7489c115dc08a = getdvarfloat(@ "hash_89b508dfec9fb80a", 15);
  level.var_ec4da42b3bbf344c.var_695b3601560f5703 = getdvarfloat(@ "hash_f2bce8bff1023a79", 1.2);
  level.var_ec4da42b3bbf344c.var_6225ce8e059e5ce5 = getdvarfloat(@ "hash_3a436a2eb1bd593", 2);
  level.var_ec4da42b3bbf344c.var_7f417534e5c75f9 = getdvarfloat(@ "hash_3382204607436afe", 0.75);
  level.var_ec4da42b3bbf344c.var_ca0a3ce7573e0780 = getdvarfloat(@ "hash_add73918ea9fcaf8", 0.2);
  level.var_ec4da42b3bbf344c.var_2d23e5b9abed638c = getdvarfloat(@ "hash_c63870e71431980a", 1.2);
  level.var_ec4da42b3bbf344c.var_5ba111ae6c83effe = getdvarint(@ "hash_345c19750d32d4a7", 0);
  level.var_ec4da42b3bbf344c.var_dbb3b2958af5562b = getdvarfloat(@ "hash_3489d22533419d85", 1);

  if(!scripts\mp\utility\game::function_d75b73c443421047()) {
    level._effect["zombie_trans"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_transition_to_human.vfx");
    level._effect["zombie_splat"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx");
    level._effect["zombie_buffed"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_buffed.vfx");
    level._effect["zombie_shout"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout.vfx");
    level._effect["zombie_shout_shockwaves"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_shockwaves.vfx");
    level._effect["vfx_mtx_s4_mutation_emp_grenade_01_vm"] = loadfx("vfx/jup/weapon/_mtx/s4/modelfx/mutation/vfx_mtx_s4_mutation_emp_grenade_01_vm.vfx");
    level._effect["vfx_jup_mut_beast_roar_aoe"] = loadfx("vfx/jup/gameplay/mutation/vfx_jup_mut_beast_roar_aoe.vfx");
    level.var_ec4da42b3bbf344c.impulsefx = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast");
  }

  waittillframeend();
  thread setupzombiepowers();
}

function addpowerbutton(powerstruct, powerref, keybindings, var_fb3a9f61fc511db4, var_91513a57aa89be6d, var_1a5269312d3a0b00, cleanupfunc, var_7939d347ade41da0, label, labelpc, cooldownsec, statusupdate, progressupdate) {
  var_2afd19924dad2b4f = hashcat(@ "hash_b75ff36b09040395", powerref);

  if(getdvarint(var_2afd19924dad2b4f, 1) == 0) {
    return;
  }

  if(isstring(keybindings)) {
    keybindings = [keybindings];
  }

  powerstruct.powers[powerref] = spawnStruct();
  powerstruct.powers[powerref].bindings = keybindings;
  powerstruct.powers[powerref].func = var_fb3a9f61fc511db4;
  powerstruct.powers[powerref].var_1a5269312d3a0b00 = var_1a5269312d3a0b00;
  powerstruct.powers[powerref].cleanupfunc = cleanupfunc;
  powerstruct.powers[powerref].var_7939d347ade41da0 = var_7939d347ade41da0;
  powerstruct.powers[powerref].label = label;
  powerstruct.powers[powerref].labelpc = labelpc;
  powerstruct.powers[powerref].cooldownsec = cooldownsec;
  powerstruct.powers[powerref].statusupdate = statusupdate;
  powerstruct.powers[powerref].progressupdate = progressupdate;
  powerstruct.powers[powerref].var_91513a57aa89be6d = var_91513a57aa89be6d;
}

function playerzombiepowers() {
  if(!level.var_ec4da42b3bbf344c.zombiepowersenabled) {
    return;
  }

  powerstruct = undefined;

  if(scripts\mp\utility\game::function_d75b73c443421047()) {
    if(self.var_e5520effcbe8bd30 == "sneaker") {
      powerstruct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099["default2"];
    }
  } else {
    powerstruct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099[self.class];
  }

  if(isbot(self)) {
    powerstruct = level.var_ec4da42b3bbf344c.var_9361e1a27424b099[self.var_6b81cdf774dac18d];
  }

  thread playerstartpowers(powerstruct);
}

function playerstartpowers(powerstruct) {
  thread playerpowerssetupkeybindings(powerstruct);
  thread playerpowershud(powerstruct);
  thread playerpowersmonitorinput(powerstruct);

  if(level.var_ec4da42b3bbf344c.hudserver) {
    thread playerpowersupdateongamepadchange(powerstruct);
  }

  thread function_539dc27334184e77(powerstruct);
  thread playerpowerscleanup(powerstruct);

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(powerstruct.powers[powerref].statusupdate)) {
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
    }
  }
}

function playerpowerssetupkeybindings(powerstruct) {
  if(isbot(self)) {
    return;
  }

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    foreach(binding in var_8723cff430a72c82.bindings) {
      self notifyonplayercommand(powerref, binding);
    }
  }
}

function playerpowershud(powerstruct) {
  var_6e2c1bd41e3923d6 = 200;
  var_6d8e1e3cbd28de50 = 18;
  assert(!isDefined(self.powershud));
  currenthudy = var_6e2c1bd41e3923d6;
  self.powershud = [];

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.label)) {
      if(level.var_ec4da42b3bbf344c.hudserver) {} else {
        self.powershud[powerref] = spawnStruct();
        self.powershud[powerref].frac = 0;
      }

      self.powershud[powerref].incooldown = 0;
      currenthudy += var_6d8e1e3cbd28de50;
    }
  }
}

function playerpowersmonitorinput(powerstruct) {
  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    thread function_a17e5100d67f2109(powerstruct, powerref);
  }
}

function function_a17e5100d67f2109(powerstruct, powerref) {
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    if(isbot(self) || self isplayerheadless()) {
      wait randomint(3);
    } else {
      self waittill(powerref);
    }

    waittillframeend();

    if(isDefined(self.powershud[powerref]) && self.powershud[powerref].incooldown) {
      function_e63114420500fb();
      continue;
    }

    overridestruct = function_71d599be2232ae52(self.class, powerref);

    if(isDefined(overridestruct) && isDefined(overridestruct.var_fb3a9f61fc511db4)) {
      func = overridestruct.var_fb3a9f61fc511db4;
      self thread[[func]](powerstruct, powerref);
      continue;
    }

    self thread[[powerstruct.powers[powerref].func]](powerstruct, powerref);
  }
}

function function_539dc27334184e77(powerstruct) {
  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.var_1a5269312d3a0b00)) {
      overridestruct = function_71d599be2232ae52(self.class, powerref);

      if(isDefined(overridestruct) && isDefined(overridestruct.var_1a5269312d3a0b00)) {
        self thread[[overridestruct.var_1a5269312d3a0b00]](powerstruct, powerref);
        continue;
      }

      self thread[[var_8723cff430a72c82.var_1a5269312d3a0b00]](powerstruct, powerref);
    }
  }
}

function playerpowerscleanup(powerstruct) {
  level endon("game_ended");
  self endon("disconnect");
  waittill_any_3("death", "zombie_unset", "zombie_set");
  thread playerpowerresetpowers(powerstruct);
  thread playerpowerscleanupkeybindings(powerstruct);
  thread playerpowerscleanuppowers(powerstruct);
  thread playerpowerscleanuphud(powerstruct);
}

function playerpowerscleanupkeybindings(powerstruct) {
  if(isbot(self)) {
    return;
  }

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    foreach(binding in var_8723cff430a72c82.bindings) {
      self notifyonplayercommandremove(powerref, binding);
    }
  }
}

function playerpowerscleanuppowers(powerstruct) {
  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.cleanupfunc)) {
      self thread[[var_8723cff430a72c82.cleanupfunc]](powerstruct, powerref);
    }
  }
}

function playerpowerscleanuphud(powerstruct) {
  if(!isDefined(self.powershud)) {
    return;
  }

  if(level.var_ec4da42b3bbf344c.hudserver) {
    foreach(hudelem in self.powershud) {
      if(isDefined(hudelem)) {
        if(isDefined(hudelem.barelem)) {
          hudelem.barelem destroyelem();
        }

        hudelem destroy();
      }
    }
  }

  self.powershud = undefined;
}

function playerpowerresetpowers(powerstruct) {
  if(!isDefined(powerstruct) || !isDefined(self.powershud)) {
    return;
  }

  self notify("disableCooldown");
  self.var_f07121951ba8e9a5 = undefined;
  self.var_741cb4edf0f0590c = undefined;
}

function playerpowersupdateongamepadchange(powerstruct) {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var_fd0efa5c23be8228 = is_player_gamepad_enabled();

  while(true) {
    var_890736e866204b96 = is_player_gamepad_enabled();

    if(var_890736e866204b96 != var_fd0efa5c23be8228) {
      var_fd0efa5c23be8228 = var_890736e866204b96;

      if(var_890736e866204b96) {
        foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
          if(isDefined(var_8723cff430a72c82.labelpc)) {
            self.powershud[powerref].label = var_8723cff430a72c82.label;
          }
        }
      } else {
        foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
          if(isDefined(var_8723cff430a72c82.labelpc)) {
            self.powershud[powerref].label = var_8723cff430a72c82.labelpc;
          }
        }
      }
    }

    waitframe();
  }
}

function function_e63114420500fb() {
  if(!isDefined(self.var_f07121951ba8e9a5) || gettime() > self.var_f07121951ba8e9a5) {
    self playlocalsound("br_pickup_deny");
    self.var_f07121951ba8e9a5 = gettime() + 1000;
  }
}

function function_f2ddb7c78178c1be(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 3);
  }

  wait level.var_ec4da42b3bbf344c.var_ca0a3ce7573e0780;

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
  }
}

function function_647ba9e9a0d700c7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");

  if(self isgestureplaying("ges_zombie_superjumpcharge")) {
    return;
  }

  if(scripts\mp\utility\weapon::grenadeinpullback()) {
    self function_187fb04ebd01baea();
  }

  while(self ismantling() || self ismeleeing()) {
    waitframe();
  }

  if(!isbot(self)) {
    self forceplaygestureviewmodel("ges_zombie_superjumpcharge");
  }

  while(self isgestureplaying("ges_zombie_superjumpcharge")) {
    if(self isonladder()) {
      self stopgestureviewmodel("ges_zombie_superjumpcharge");
      break;
    }

    waitframe();
  }
}

function playerpowerstartcooldown(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(self.powershud[powerref]) || istrue(self.powershud[powerref].incooldown)) {
    return;
  }

  var_67bf71bf64a4c87f = self.powershud[powerref];

  if(level.var_ec4da42b3bbf344c.powerscooldown && var_67bf71bf64a4c87f.frac > 0) {
    self.powershud[powerref].incooldown = 1;
    cooldownsec = powerstruct.powers[powerref].cooldownsec;
    var_b1f7ce0445d66ac9 = hashcat(@ "hash_a726fd9fdb5568e5", powerref);

    if(getdvarint(var_b1f7ce0445d66ac9, 0) != 0) {
      cooldownsec = getdvarint(var_b1f7ce0445d66ac9, 0);
    }

    if(_hasperk("specialty_mutation_mode_bonus_01") && !istrue(self.var_747fc410433aa51c)) {
      self.var_747fc410433aa51c = 1;
      cooldownsec = int(cooldownsec / 2);
    }

    thread function_90f6fbbb6332dadd(powerstruct, powerref, cooldownsec, int(var_67bf71bf64a4c87f.frac * 100));
    fraction = var_67bf71bf64a4c87f.frac;
    cooldownsec *= fraction;

    if(level.var_ec4da42b3bbf344c.hudserver) {
      var_67bf71bf64a4c87f.barelem.bar.color = (1, 0.6, 0);
      var_67bf71bf64a4c87f.barelem.bar scaleovertime(cooldownsec, 0, var_67bf71bf64a4c87f.barelem.height);
    }

    waittill_notify_or_timeout(powerref + "_cooldown_cancel", cooldownsec);
    var_6538d60a6fdba877 = "zxp_restock_" + powerref;
    self playlocalsound(var_6538d60a6fdba877);
    self.powershud[powerref].incooldown = 0;
  } else {
    if(level.var_ec4da42b3bbf344c.hudserver) {
      var_67bf71bf64a4c87f.barelem updatebar(0, 0);
    } else {
      var_67bf71bf64a4c87f.frac = 0;
    }

    thread function_90f6fbbb6332dadd(powerstruct, powerref, 0, 0);
  }

  if(level.var_ec4da42b3bbf344c.hudserver) {
    var_67bf71bf64a4c87f.barelem.bar.color = (1, 1, 1);
  }

  if(isDefined(powerstruct.powers[powerref].var_7939d347ade41da0)) {
    self[[powerstruct.powers[powerref].var_7939d347ade41da0]](powerstruct, powerref);
  }
}

function function_90f6fbbb6332dadd(powerstruct, powerref, cooldownsec, var_25ccce114196d19c) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(powerstruct.powers[powerref].statusupdate) || !isDefined(powerstruct.powers[powerref].progressupdate)) {
    return;
  }

  function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 1);
  durationms = cooldownsec * 1000 * var_25ccce114196d19c / 100;
  starttime = gettime();
  endtime = starttime + durationms;

  while(gettime() < endtime) {
    var_a0dfc893004c6eb3 = gettime();
    fraction = (endtime - gettime()) / durationms;
    progress = fraction * var_25ccce114196d19c;
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, int(progress));

    if(function_f3bb4f4911a1beb2("game", "hasMutationModePerk03") && istrue(self.var_5651e2b694c25c8b) && istrue(powerstruct.powers[powerref].istactical)) {
      self.var_5651e2b694c25c8b = 0;
      self notify(powerref + "_cooldown_cancel");
      break;
    }

    waitframe();
  }

  function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
  function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
}

function function_120695737abd78f4(powerstruct, powerref) {
  if(level.var_ec4da42b3bbf344c.hudserver) {
    self.powershud[powerref].barelem updatebar(1, 0);
  } else {
    self.powershud[powerref].frac = 1;
  }

  thread playerpowerstartcooldown(powerstruct, powerref);
}

function function_ae8ecf6e5f68f1ea(errormessage) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie)) {
    return;
  }

  if(!isDefined(errormessage)) {
    return;
  }

  zombie scripts\mp\hud_message::showerrormessage(errormessage);
}

function function_dad92e6ab5aa6f51(var_716d5c42a00a0d4c, powerref, var_fb3a9f61fc511db4, var_1a5269312d3a0b00) {
  if(!isDefined(level.var_f6b0a1b4b5b7151c)) {
    level.var_f6b0a1b4b5b7151c = [];
  }

  if(!isDefined(level.var_f6b0a1b4b5b7151c[var_716d5c42a00a0d4c])) {
    level.var_f6b0a1b4b5b7151c[var_716d5c42a00a0d4c] = [];
  }

  level.var_f6b0a1b4b5b7151c[var_716d5c42a00a0d4c][powerref] = spawnStruct();
  level.var_f6b0a1b4b5b7151c[var_716d5c42a00a0d4c][powerref].var_fb3a9f61fc511db4 = var_fb3a9f61fc511db4;
  level.var_f6b0a1b4b5b7151c[var_716d5c42a00a0d4c][powerref].var_1a5269312d3a0b00 = var_1a5269312d3a0b00;
}

function function_71d599be2232ae52(class, powerref) {
  if(!isDefined(level.var_f6b0a1b4b5b7151c)) {
    return undefined;
  }

  if(!isDefined(level.var_f6b0a1b4b5b7151c[self.class])) {
    return undefined;
  }

  if(!isDefined(level.var_f6b0a1b4b5b7151c[self.class][powerref])) {
    return undefined;
  }

  return level.var_f6b0a1b4b5b7151c[self.class][powerref];
}

function function_936f0ef6e203a7fc(dataref, value) {
  if(!istrue(level.var_ec4da42b3bbf344c.zombiepowersenabled)) {
    return;
  }

  bitoffset = 0;
  bitwidth = 0;

  switch (dataref) {
    case #"hash_6fdca435002399b7":
      bitoffset = 0;
      bitwidth = 2;
      break;
    case #"hash_903c3a93257a45fe":
      bitoffset = 2;
      bitwidth = 7;
      break;
    case #"hash_33f6e05f0765624c":
      bitoffset = 9;
      bitwidth = 3;
      break;
    case #"hash_11b1be2500f780fd":
      bitoffset = 12;
      bitwidth = 7;
      break;
    case #"hash_b2d5d8995a0d93ca":
      bitoffset = 19;
      bitwidth = 2;
      break;
    case #"hash_9af3d492597d7bbb":
      bitoffset = 21;
      bitwidth = 7;
      break;
    case #"hash_d4536c3cd58937a6":
      bitoffset = 28;
      bitwidth = 2;
      break;
    default:
      assertmsg("<dev string:x1c>" + dataref + "<dev string:x3c>");
      break;
  }

  if(!isDefined(level.var_ce83fb46b0b7d8f3)) {
    level.var_ce83fb46b0b7d8f3 = [];
  }

  if(!isDefined(level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"])) {
    level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"] = 0;
  }

  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (int(value) &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  prevvalue = self getclientomnvar("ui_br_zombie_powers");
  cleanedbase = prevvalue &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;
  level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"] = var_82a90e56e416fa55;
  self setclientomnvar("ui_br_zombie_powers", level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"]);
}