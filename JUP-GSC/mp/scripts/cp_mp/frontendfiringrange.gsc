/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\frontendfiringrange.gsc
*************************************************/

#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\frontendutils;
#using scripts\cp_mp\operator;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\utility\hitmarker;
#namespace namespace_a406dc37134c52b;

function function_2bef3a70387bed5() {
  if(getomnvar("ui_firing_range_has_started") == 1) {
    function_75723f405bab9463();
    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon) && isDefined(currentweapon.weaponblueprint)) {
      setomnvar("ui_firing_range_weapon_in_use_loot_index", currentweapon.weaponblueprint.lootid);
      return;
    }

    setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);
  }
}

function frontend_spawnplayer() {
  println("<dev string:x1c>");
  level.transient_soundbanks = spawn("sound_transient_soundbanks", (0, 0, 0));
  level.transient_soundbanks settransientsoundbank("jup_frontend_firingrange.all", 1);
  self.guid = 0;
  self.team = "allies";
  groundpos = utility::groundpos(level.var_aeb531c63a3266d6.basecam.origin);
  self spawn(groundpos, level.var_aeb531c63a3266d6.basecam.angles);
  waitframe();
  updateplayerweapon();
  self setclienttriggeraudiozone("frontend_firingrange", 0.25);
  self setsoundsubmix("jup_frontend_firingrange", 3);

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  viewmodelname = self getcustomizationviewmodel();
  self setModel(bodymodelname);
  self setviewmodel(viewmodelname);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }

  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  level.playerviewowner.var_e7a9752e4f4c7d97 = undefined;
  level.playerviewowner namespace_46e942396566f2da::function_c72573fb42d0cdbc();
}

function function_ad45f79e3a9b4d2(var_fe2109095a023ed7) {
  if(var_fe2109095a023ed7) {
    function_56f34b9a1463755c();
  }

  println("<dev string:x2f>");
  self.sessionstate = "playing";
  self.statusicon = "";

  if(istrue(self.settospectate)) {
    self.settospectate = 0;
    waitframe();
    frontend_spawnplayer();
  }
}

function updateplayerweapon() {
  if(isDefined(self.primaryweaponobj)) {
    self takeweapon(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none") {
    self takeweapon(self.secondaryweaponobj);
  }

  self.primaryweaponobj = undefined;
  self.secondaryweaponobj = undefined;
  loadoutdata = self function_a91eac707383a642();
  self.primaryweaponobj = loadoutdata.primaryweaponentityindex;
  self giveweapon(self.primaryweaponobj);
  self setweaponammoclip(self.primaryweaponobj, weaponclipsize(self.primaryweaponobj));
  self setweaponammostock(self.primaryweaponobj, weaponmaxammo(self.primaryweaponobj));
  self setactionslot(3, "altmode");
  self.secondaryweaponobj = loadoutdata.secondaryweaponentityindex;
  self giveweapon(self.secondaryweaponobj);
  self setweaponammoclip(self.secondaryweaponobj, weaponclipsize(self.secondaryweaponobj));
  self setweaponammostock(self.secondaryweaponobj, weaponmaxammo(self.secondaryweaponobj));
  self switchtoweaponimmediate(self.primaryweaponobj);

  if(isDefined(self.primaryweaponobj) && isDefined(self.primaryweaponobj.weaponblueprint)) {
    setomnvar("ui_firing_range_weapon_in_use_loot_index", self.primaryweaponobj.weaponblueprint.lootid);
  } else {
    setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);
  }

  if(!isDefined(level.playerviewowner.operatorcustomization)) {
    level.playerviewowner.operatorcustomization = spawnStruct();
  }

  level.playerviewowner.operatorcustomization.skinref = loadoutdata.skinref;

  if(isDefined(loadoutdata.skinref) && loadoutdata.skinref != "") {
    reactiveoperator = scripts\cp_mp\operator::function_2dc6ef8b84dfec64(loadoutdata.skinref);

    if(isDefined(reactiveoperator) && reactiveoperator != "") {
      level.playerviewowner function_602b3de054f2a81(reactiveoperator);
    }
  }

  thread function_b74a4c79011e5adf(self.primaryweaponobj);
}

function updateweaponswitch() {
  self notify("updateWeaponSwitch");
  self endon("updateWeaponSwitch");

  for(previousweap = undefined; true; previousweap = weapon) {
    self waittill("weapon_change");
    level.var_37a55ecaf979d920 = 0;
    level.var_91d278fb245d797b = 0;
    level.var_febc1f5f6fc40f70 = 0;
    level.bulletshitsecondary = 0;
    setomnvar("ui_firing_range_accuracy", 0);
    setomnvar("ui_firing_range_target_kill_count", 0);
    weapon = self getcurrentweapon();
    rootname = getweaponrootname(weapon.basename);

    switch (rootname) {
      case #"hash_8d9ae5e5dd390b4b":
        thread scripts\cp_mp\crossbow::initcrossbowusage();
        thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);
        break;
    }

    if(isDefined(weapon) && isDefined(weapon.weaponblueprint)) {
      setomnvar("ui_firing_range_weapon_in_use_loot_index", weapon.weaponblueprint.lootid);
    } else {
      setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);
    }

    namespace_46e942396566f2da::function_b939bc4f3a6d4fdc(weapon);
    function_b770c0d79c3b668(weapon, previousweap);
  }
}

function function_b770c0d79c3b668(currweaponobj, prevweaponobj) {
  weaponattachmentperkupdate(currweaponobj, prevweaponobj);
}

function weaponattachmentperkupdate(currweaponobj, prevweaponobj) {
  newattachments = undefined;
  oldattachments = undefined;

  if(!isundefinedweapon(prevweaponobj)) {
    oldattachments = getweaponattachments(prevweaponobj);

    if(isDefined(oldattachments) && oldattachments.size > 0) {
      foreach(oldattach in oldattachments) {
        perks = function_de5d0db99cd9bfd7(prevweaponobj, oldattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          function_2ee11f200bf73e2(perk);
        }
      }
    }
  }

  if(!isundefinedweapon(currweaponobj)) {
    newattachments = getweaponattachments(currweaponobj);

    if(isDefined(newattachments) && newattachments.size > 0) {
      foreach(newattach in newattachments) {
        perks = function_de5d0db99cd9bfd7(currweaponobj, newattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          frontend_giveperk(perk);
        }
      }
    }
  }
}

function function_de5d0db99cd9bfd7(weaponobj, attachmentname) {
  attachperks = function_4f344ec5b7c45a3f(weaponobj, attachmentname);

  if(isDefined(attachperks)) {
    var_aaf9287b9184ca14 = [];

    foreach(perk in attachperks) {
      var_d9d32f098f69c77f = function_3350b04cb0437d15(perk);

      if(isDefined(var_d9d32f098f69c77f)) {
        var_aaf9287b9184ca14[var_aaf9287b9184ca14.size] = var_d9d32f098f69c77f;
      }
    }

    return var_aaf9287b9184ca14;
  }

  return undefined;
}

function function_3350b04cb0437d15(perk) {
  switch (perk) {
    case #"hash_fbc8c549d7e39757":
      return "specialty_fastreload";
  }

  return undefined;
}

function frontend_giveperk(perk) {
  self setperk(perk, 1);
}

function function_2ee11f200bf73e2(perk) {
  self unsetperk(perk, 1);
}

function function_a0c6c9f9a16b236() {
  updateplayerweapon();
  function_ad45f79e3a9b4d2(1);
}

function loadout_giveperk(perkname) {
  if(!isDefined(self.loadoutperks)) {
    self.loadoutperks = [];
  }

  self setperk(perkname, 1);
  self.loadoutperks[self.loadoutperks.size] = perkname;
}

function function_cb993ebadda105c7() {
  setomnvar("ui_firing_range_has_started", 1);
  function_daa1538470157756();

  foreach(trig in level.lanetriggers) {
    trig.var_27654d98d67bccc8 = 0;
  }

  if(function_914509f96205b92d()) {
    level.var_81756a36088f74a4 = gettime();
    level.var_ee0f9b1b1e7e1dce = 0;
    level.var_9f4cede9e6b31bf0 = 0;
    level.var_ce3c34eac4202086 = 0;
    level.var_50f8b730d8c5eae4 = 0;
  }

  level thread function_f00185b72cdb3b04();
  level.var_37a55ecaf979d920 = 0;
  level.var_91d278fb245d797b = 0;
  level.var_febc1f5f6fc40f70 = 0;
  level.bulletshitsecondary = 0;
  level.var_31b6d2832a330f45 = 0;
  level.var_4e5b1ceaad66b065 = 0;
  level.gamemodebundle = getgamemodescriptbundle();
  setomnvar("ui_firing_range_accuracy", 0);
  setomnvar("ui_firing_range_target_kill_count", 0);

  if(function_42c8b6ff9adfabfa()) {
    setDvar(@ "hash_4033da1e021e6d5", 0);
    level.var_dd19f80de7b179be = gettime();
    level.var_b8494e78ab9bc23e = 0;
    level.var_6ba74ccd0535dfab = 0;
    level.var_e89e680520310188 = 0;
    level.var_a9a55beb5763b7d5 = 0;
  }

  println("<dev string:x52>");
  suitname = default_to(level.gamemodebundle.playerdefaultsuit, "jup_defaultsuit_mp");
  self setsuit(suitname);
  println("<dev string:x2f>");
  self.sessionstate = "playing";
  self.statusicon = "";
  waitframe();
  println("<dev string:x1c>");
  groundpos = utility::groundpos(level.var_aeb531c63a3266d6.basecam.origin);
  self spawn(groundpos, level.var_aeb531c63a3266d6.basecam.angles);
  waitframe();
  waitframe();
  self.settospectate = 0;
  frontend_spawnplayer();
  function_f9ef7bd954fb4194();
  loadout_giveperk("specialty_pistoldraw");
  thread function_ad11142812a6dc9f();
  thread infiniteammo();
  thread updateweaponswitch();

  thread function_1a2a24c0225bef64();

  thread function_bd002aab782c389e();
}

function function_ad11142812a6dc9f() {
  level endon("exit_firing_range");
  self notify("resetWeaponStats");
  self endon("resetWeaponStats");

  while(true) {
    level waittill("firing_range_weapon_stats_reset");
    function_f9ef7bd954fb4194();
  }
}

function function_f9ef7bd954fb4194() {
  self.var_e1dba856ddad901c = 0;
  self.var_a178e0e81678156e = 0;
  self.var_6d2bd0a2ed13ec40 = 0;
  self.var_606aa5ed269e77a2 = 0;
  self.var_48c21e566da576af = 0;
  self.var_7c9bab5e596fecef = 0;
  self.var_6efaff3e096450a4 = 0;
  self.var_f259c331aef28ae6 = 0;
  self.var_cce2e6acbfa28188 = 0;
  self.var_5a7d6d9abfe5d84a = 0;
  self .57 edec18_1172_akid = 0;
  self.var_e3e14a52f2ad7e07 = 0;
}

function function_a52f1e6528800c39() {
  self.settospectate = 1;

  if(isDefined(self.primaryweaponobj)) {
    if(self hasweapon(self.primaryweaponobj)) {
      self takeweapon(self.primaryweaponobj);
      self clearclienttriggeraudiozone(3);
      self clearsoundsubmix("jup_frontend_firingrange", 3);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    if(self hasweapon(self.secondaryweaponobj)) {
      self takeweapon(self.secondaryweaponobj);
    }
  }

  self suicide();
  level.transient_soundbanks settransientsoundbank("jup_frontend_firingrange.all", 0);
  waitframe();
  level.transient_soundbanks delete();
  self allowspectateteam("none", 1);
  self.sessionstate = "spectator";
}

function function_42c8b6ff9adfabfa() {
  return getdvarint(@ "hash_e46b4b4f19be660b", 0) == 1 && getdvarint(@ "hash_c006752ec3578568", -1) > -1;
}

function function_847107a04c7fc7fb() {
  var_40f233f0d24307d6 = ["bundle_id", getdvarint(@ "hash_c006752ec3578568"), "nb_bullet_fired", level.var_b8494e78ab9bc23e, "nb_inspection", getdvarint(@ "hash_4033da1e021e6d5"), "nb_target_killed", level.var_a9a55beb5763b7d5, "accuracy", level.var_e89e680520310188, "time_spent_in_firing_range", gettime() - level.var_dd19f80de7b179be];
  dlog_recordevent("dlog_event_try_a_gun_stats", var_40f233f0d24307d6);
}

function function_914509f96205b92d() {
  return getdvarint(@ "hash_3e7f94c85db5827a", 1) == 1;
}

function function_a3931d4b9b90f0e1() {
  if(!function_914509f96205b92d()) {
    return;
  }

  var_7e45a75e369b0163 = ["time_spent_in_firing_range", gettime() - level.var_81756a36088f74a4, "last_primary_weapon", self.primaryweaponobj.basename, "last_primary_type", "todo", "last_seconday_weapon", self.secondaryweaponobj.basename, "last_secondary_type", "todo", "last_bullets_fired", level.var_37a55ecaf979d920 + level.var_febc1f5f6fc40f70, "last_targets_killed", getomnvar("ui_firing_range_target_kill_count"), "last_accuracy", getomnvar("ui_firing_range_accuracy"), "num_plates_zero", level.var_ee0f9b1b1e7e1dce, "num_plates_one", level.var_9f4cede9e6b31bf0, "num_plates_two", level.var_ce3c34eac4202086, "num_plates_three", level.var_50f8b730d8c5eae4];
  dlog_recordevent("dlog_event_firing_range_stats", var_7e45a75e369b0163);
}

function function_3ec902beadbe5e8d() {
  if(!function_914509f96205b92d()) {
    return;
  }

  switch (level.var_37e9d3ecafdb61dc) {
    case 0:
      level.var_ee0f9b1b1e7e1dce++;
      break;
    case 1:
      level.var_9f4cede9e6b31bf0++;
      break;
    case 2:
      level.var_ce3c34eac4202086++;
      break;
    case 3:
      level.var_50f8b730d8c5eae4++;
      break;
  }
}

function function_6ddbfa779dce4b5d() {
  function_a3931d4b9b90f0e1();
  function_a52f1e6528800c39();
  self setspectatedefaults(level.camera_loadout_showcase_overview.basecam.origin, level.camera_loadout_showcase_overview.basecam.angles);
  self cameralinkTo(level.camera_anchor, "tag_origin");
  setomnvar("ui_firing_range_has_started", 0);
  setomnvar("ui_firing_range_lane", -1);
  function_4738968c0cd77b51();

  if(function_42c8b6ff9adfabfa()) {
    function_847107a04c7fc7fb();
    setDvar(@ "hash_c006752ec3578568", -1);
  }

  level.var_37a55ecaf979d920 = 0;
  level.var_91d278fb245d797b = 0;
  level.var_febc1f5f6fc40f70 = 0;
  level.bulletshitsecondary = 0;
  level.var_31b6d2832a330f45 = 0;
  level.var_4e5b1ceaad66b065 = 0;
  function_f9ef7bd954fb4194();
  setomnvar("ui_firing_range_accuracy", 0);
  setomnvar("ui_firing_range_target_kill_count", 0);
  level notify("exit_firing_range");

  foreach(target in level.var_e0fd2fccbeadef41) {
    target thread respawntarget();
  }
}

function function_31c28009668de7ec() {
  if(getomnvar("ui_firing_range_has_started") == 1) {
    function_75723f405bab9463();
    function_6ddbfa779dce4b5d();
  }
}

function infiniteammo() {
  level endon("exit_firing_range");
  self notify("infiniteAmmo");
  self endon("infiniteAmmo");

  while(true) {
    weapons = self getweaponslistprimaries();

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammostock(weapon, weaponmaxammo(weapon));
    }

    waitframe();
  }
}

function function_1a2a24c0225bef64() {
  level endon("<dev string:x62>");

  while(true) {
    var_a0743e8d0d19bed8 = getdvarint(@ "hash_ba7afa4a670ade73", -1);

    if(var_a0743e8d0d19bed8 != -1) {
      setDvar(@ "hash_ba7afa4a670ade73", -1);
      self notify("<dev string:x77>", "<dev string:x8a>", var_a0743e8d0d19bed8);
    }

    waitframe();
  }
}

function function_7086103bdf1f2c05(numplates) {
  var_9a4a482cac1b5c20 = level.var_37e9d3ecafdb61dc;
  level.var_37e9d3ecafdb61dc = int(max(0, numplates));
  setomnvar("ui_firing_range_num_dummy_plates", level.var_37e9d3ecafdb61dc);

  foreach(ent in level.var_e0fd2fccbeadef41) {
    ent.var_c284c09ef7780e64.health = function_314b6888c85326db();
  }

  if(var_9a4a482cac1b5c20 != level.var_37e9d3ecafdb61dc) {
    function_3ec902beadbe5e8d();
  }
}

function function_bd002aab782c389e() {
  self endon("disconnect");
  level endon("game_ended");
  level endon("exit_firing_range");

  while(true) {
    self waittill("luinotifyserver", channel, val);

    if(channel == "ui_set_dummy_num_plates") {
      function_7086103bdf1f2c05(val);
    }
  }
}

function function_314b6888c85326db() {
  return function_c0ebb986ef34456d() + level.var_37e9d3ecafdb61dc * 50;
}

function function_c0ebb986ef34456d() {
  defaultmaxhealth = getdvarint(@ "scr_player_maxhealth", 150);

  if(getdvarint(@ "ui_is_magma_gamemode", 0) == 1) {
    defaultmaxhealth = getdvarint(@ "hash_cb5458a36c2b39d9", 150);
  }

  return defaultmaxhealth;
}

function function_f00185b72cdb3b04() {
  if(!isDefined(level.var_e0fd2fccbeadef41)) {
    if(!isDefined(level.var_37e9d3ecafdb61dc)) {
      level.var_37e9d3ecafdb61dc = 0;
    }

    level.var_e0fd2fccbeadef41 = function_abdba932e247d9c2("enemyTarget");

    foreach(ent in level.var_e0fd2fccbeadef41) {
      ent.var_c284c09ef7780e64 = spawn("script_origin", ent.origin);
      ent.var_c284c09ef7780e64.owner = ent;
      ent.var_c284c09ef7780e64.health = function_314b6888c85326db();
      ent.brushes = getEntArray(ent.target, "targetname");

      foreach(brush in ent.brushes) {
        brush.owner = ent;
        brush thread function_66cdac98ac1a8a6a();
      }

      ent.var_c284c09ef7780e64 thread function_487345ce6a43a653();
      ent thread function_66cdac98ac1a8a6a(1);
      ent namespace_46e942396566f2da::function_c72573fb42d0cdbc();

      if(getdvarint(@ "hash_19cb7a793ce35f97", 0) == 0) {
        ent thread function_26f9a6ab8c0254ba();
      }
    }
  } else {
    foreach(ent in level.var_e0fd2fccbeadef41) {
      ent.var_c284c09ef7780e64.health = function_314b6888c85326db();
    }
  }

  function_3ec902beadbe5e8d();
}

function function_26f9a6ab8c0254ba() {
  defaultpos = self.origin + (0, 0, 40);
  self.lastimpactpos = defaultpos;
  defaultdir = (0, 0, 1);
  self.var_f83a9d5c8d6b9a96 = defaultdir;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, inflector);
    defaultpos = self.origin + (0, 0, 40);

    if(distance(point, defaultpos) < 48) {
      self.lastimpactpos = point;
      self.var_f83a9d5c8d6b9a96 = direction_vec;
    } else {
      self.lastimpactpos = defaultpos;
      self.var_f83a9d5c8d6b9a96 = defaultdir;
    }

    level thread drawsphere(self.lastimpactpos, 2, 5, (1, 0, 0));
  }
}

function function_66cdac98ac1a8a6a(ismodel) {
  self setCanDamage(1);
  data = spawnStruct();
  data.damage = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, inflector);
    attacker = level.playerviewowner;
    victim = self.owner;

    if(istrue(ismodel)) {
      victim = self;

      if(isbulletdamage(meansofdeath) || meansofdeath == "MOD_EXPLOSIVE_BULLET") {
        continue;
      }
    }

    hitloc = "torso_upper";

    if(isDefined(self.script_noteworthy)) {
      switch (self.script_noteworthy) {
        case #"hash_fc2fdaa21f480e36":
          hitloc = "torso_upper";
          break;
        case #"hash_b107b5547c755d23":
          hitloc = "head";
          break;
        case #"hash_c9b61a3a17a5fc6c":
          hitloc = "left_leg_upper";
          break;
        case #"hash_ca6516c10db2c95":
        case #"hash_7f9c384a34cc392f":
          hitloc = "left_arm_upper";
          break;
      }
    }

    currenttime = gettime();
    data.origin = self.origin;
    data.attacker = attacker;
    data.meansofdeath = meansofdeath;
    data.weapon = attacker getcurrentweapon();
    data.hitloc = hitloc;
    data.idflags = idflags;

    if(data.idflags & 262144) {
      weapondamagetype = 2;
    } else {
      weapondamagetype = 0;
    }

    scaleddamage = int(floor(damage * getweaponhitlocdamagemultiplier(attacker getcurrentweapon(), hitloc, weapondamagetype)));
    data.damage = scaleddamage;

    if(isspreadweapon(data.weapon)) {
      data.damage = spreadshotdamagemod(victim, data.attacker, data.weapon, data.damage, data.idflags);
    }

    if(data.damage > 0) {
      print3d(self.origin, data.damage, (1, 0, 0), 1, 0.75, 100, 1);

      victim thread processdamagethisframe(data);
    }
  }
}

function processdamagethisframe(instance) {
  var_c284c09ef7780e64 = self.var_c284c09ef7780e64;

  if(var_c284c09ef7780e64.health <= 0) {
    return;
  }

  if(!isDefined(level.var_daf783f0070eccb5) || level.var_daf783f0070eccb5.damage < instance.damage) {
    level.var_daf783f0070eccb5 = instance;
  }

  level notify("processDamageThisFrame");
  level endon("processDamageThisFrame");
  waittillframeend();
  instance = level.var_daf783f0070eccb5;
  level.var_daf783f0070eccb5 = undefined;
  var_3b42c59f79c3f077 = function_c0ebb986ef34456d();
  hasarmor = var_c284c09ef7780e64.health > var_3b42c59f79c3f077;
  var_eca68f675aa4abe5 = function_c0ebb986ef34456d() + 150;
  hitmarkertype = "standard";
  armordamage = 0;
  armorbroke = 0;

  if(hasarmor) {
    currentarmor = var_c284c09ef7780e64.health - var_3b42c59f79c3f077;
    armordamage = int(clamp(instance.damage, 0, currentarmor));
    armorbroke = currentarmor - armordamage == 0;
  }

  shouldohkprotect = function_43702519a3dc0854(instance.meansofdeath) && armordamage >= 150;
  var_520f3f243189ca25 = function_ae24f0c0c8c6de2a(instance.weapon);
  var_84b2b2a1586de527 = var_c284c09ef7780e64.health >= var_eca68f675aa4abe5;

  if(shouldohkprotect && var_84b2b2a1586de527) {
    if(instance.damage >= var_c284c09ef7780e64.health && !istrue(var_520f3f243189ca25)) {
      instance.damage = int(clamp(instance.damage, 0, var_c284c09ef7780e64.health - 1));
    }
  }

  var_c284c09ef7780e64 dodamage(instance.damage, instance.origin, instance.attacker, instance.attacker, instance.meansofdeath, instance.weapon, instance.hitloc);
  level notify("damage_done");
  isheadshot = instance.hitloc == "head";
  hitdist = math::round_float(distance(instance.attacker.origin, var_c284c09ef7780e64.origin) / 39.37, 2);
  ignoreaccuracy = isDefined(instance.meansofdeath) && instance.meansofdeath == "MOD_FIRE" || instance.meansofdeath == "MOD_EXPLOSIVE";

  if(!ignoreaccuracy) {
    bulletsfired = 1;
    bulletshit = 1;

    if(instance.attacker getcurrentweapon() == instance.attacker.primaryweaponobj) {
      level.var_91d278fb245d797b = min(level.var_91d278fb245d797b + 1, level.var_37a55ecaf979d920);
      bulletshit = level.var_91d278fb245d797b;
      bulletsfired = level.var_37a55ecaf979d920;

      if(function_42c8b6ff9adfabfa()) {
        level.var_6ba74ccd0535dfab++;
        var_b8494e78ab9bc23e = max(1, level.var_b8494e78ab9bc23e);
        level.var_e89e680520310188 = clamp(level.var_6ba74ccd0535dfab / var_b8494e78ab9bc23e, 0, 1);
      }

      if(isheadshot) {
        level.var_31b6d2832a330f45++;
        playsoundatpos(instance.origin, "jup_firingrange_target_bullet_impact_headshot");
      }

      if(bulletsfired > 0) {
        instance.attacker.var_a178e0e81678156e = clamp(level.var_31b6d2832a330f45 / bulletsfired, 0, 1);
        instance.attacker.var_6d2bd0a2ed13ec40 = clamp(bulletshit / bulletsfired, 0, 1);
      } else {
        instance.attacker.var_a178e0e81678156e = 0;
        instance.attacker.var_6d2bd0a2ed13ec40 = 0;
      }

      instance.attacker.var_606aa5ed269e77a2 += int(instance.damage);
      instance.attacker.var_48c21e566da576af = int(instance.damage);
      instance.attacker.var_7c9bab5e596fecef = clamp(hitdist, 0, 100);
      playsoundatpos(instance.origin, "jup_firingrange_target_bullet_impact");
    } else {
      level.bulletshitsecondary = min(level.bulletshitsecondary + 1, level.var_febc1f5f6fc40f70);
      bulletshit = level.bulletshitsecondary;
      bulletsfired = level.var_febc1f5f6fc40f70;

      if(isheadshot) {
        level.var_4e5b1ceaad66b065++;
        playsoundatpos(instance.origin, "jup_firingrange_target_bullet_impact_headshot");
      }

      if(bulletsfired > 0) {
        instance.attacker.var_f259c331aef28ae6 = clamp(level.var_4e5b1ceaad66b065 / bulletsfired, 0, 1);
        instance.attacker.var_cce2e6acbfa28188 = clamp(bulletshit / bulletsfired, 0, 1);
      } else {
        instance.attacker.var_f259c331aef28ae6 = 0;
        instance.attacker.var_cce2e6acbfa28188 = 0;
      }

      instance.attacker.var_5a7d6d9abfe5d84a += int(instance.damage);
      instance.attacker .57 edec18_1172_akid = int(instance.damage);
      instance.attacker.var_e3e14a52f2ad7e07 = clamp(hitdist, 0, 100);
      playsoundatpos(instance.origin, "jup_firingrange_target_bullet_impact");
    }

    bulletsfired = max(1, bulletsfired);

    if(bulletsfired > 0) {
      accuracy = clamp(bulletshit / bulletsfired, 0, 1);
    } else {
      accuracy = 0;
    }

    setomnvar("ui_firing_range_accuracy", accuracy);
    println("<dev string:xa5>" + accuracy);
  }

  var_a9acac74f8733ef9 = getdvarint(@ "hash_c0bf29e81b3a5eec", 1);
  var_e97d8200c5b56592 = getdvarint(@ "hash_d1eeda3bc1bfb41b", 1);
  icontype = undefined;
  hitsound = getDvar(@ "hash_d6875627fd8914de");

  if(var_a9acac74f8733ef9 || var_e97d8200c5b56592) {
    if(armorbroke) {
      if(var_a9acac74f8733ef9) {
        if(var_c284c09ef7780e64.health + instance.damage >= var_eca68f675aa4abe5) {
          icontype = "hitarmormaxplatebreak";
        } else {
          icontype = "hitarmorlightbreak";
        }

        if(var_84b2b2a1586de527) {
          hitmarkertype = "threeplatearmorbreak";
        } else {
          hitmarkertype = "standardarmorbreak";
        }
      }

      if(var_e97d8200c5b56592) {
        hitsound = "hit_marker_3d_armor_break";
      }
    } else if(hasarmor) {
      if(var_a9acac74f8733ef9) {
        if(var_c284c09ef7780e64.health + instance.damage >= var_eca68f675aa4abe5) {
          icontype = "hitarmorlightmaxlevel";
        } else {
          icontype = "hitarmorlight";
        }

        if(var_84b2b2a1586de527) {
          hitmarkertype = "threeplatearmor";
        } else {
          hitmarkertype = "standardarmor";
        }
      }
    }
  }

  if(var_c284c09ef7780e64.health <= 0) {
    if(scripts\common\utility::getdamagetype(instance.meansofdeath) == "bullet" && getdvarint(@ "hash_19cb7a793ce35f97", 0) == 0) {
      var_c284c09ef7780e64.owner function_934dd81d5e332be8(var_c284c09ef7780e64.owner.lastimpactpos, var_c284c09ef7780e64.owner.var_f83a9d5c8d6b9a96, instance.attacker, instance.weapon, 1);
    }

    prevvalue = getomnvar("ui_firing_range_target_kill_count");

    if(prevvalue <= 500) {
      setomnvar("ui_firing_range_target_kill_count", prevvalue + 1);
    }

    if(function_42c8b6ff9adfabfa()) {
      level.var_a9a55beb5763b7d5++;
    }

    if(instance.attacker getcurrentweapon() == instance.attacker.primaryweaponobj) {
      if(instance.attacker.var_e1dba856ddad901c <= 500) {
        instance.attacker.var_e1dba856ddad901c++;
      }
    } else if(instance.attacker.var_6efaff3e096450a4 <= 500) {
      instance.attacker.var_6efaff3e096450a4++;
    }

    if(isheadshot) {
      self playsoundtoplayer("mp_headshot_alert", instance.attacker);
    } else {
      self playsoundtoplayer("mp_kill_alert", instance.attacker);
    }

    playsoundatpos(instance.origin + (0, 0, 15), "jup_firingrange_target_bullet_impact_death");
    instance.attacker scripts\mp\utility\hitmarker::function_2a968ddf3c277ce(hitmarkertype, 1, isheadshot, 0, icontype);
    thread function_76ec949f11311da1(var_c284c09ef7780e64);
    deathdata = spawnStruct();
    deathdata.attacker = instance.attacker;
    deathdata.objweapon = instance.weapon;
    deathdata.meansofdeath = instance.meansofdeath;
    deathdata.hitloc = instance.hitloc;
    self.body = self;
    namespace_46e942396566f2da::function_d7c5900c7d5bb0db(deathdata);
    return;
  }

  playsoundatpos(instance.origin, hitsound);
  instance.attacker scripts\mp\utility\hitmarker::function_2a968ddf3c277ce(hitmarkertype, 0, isheadshot, 0, icontype);
}

#using_animtree("script_model");

function function_76ec949f11311da1(var_c284c09ef7780e64) {
  level endon("exit_firing_range");

  if(istrue(self.var_9a74c6fbe0cf64eb)) {
    return;
  }

  self.var_9a74c6fbe0cf64eb = 1;
  var_c284c09ef7780e64 setCanDamage(0);
  self disableaimassist();
  self notsolid();
  self notify("entitydeleted");
  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_death");
  self playSound("uin_firingrange_target_fall");
  wait getanimlength(%iw9_mp_firingrange_dummy_death);
  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_deathidle");
  wait 3;
  playsoundatpos(self.origin, "uin_firingrange_target_rise");
  thread respawntarget();
}

function respawntarget() {
  if(!istrue(self.var_9a74c6fbe0cf64eb)) {
    return;
  }

  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_respawn");
  self.var_9a74c6fbe0cf64eb = 1;
  wait getanimlength(%iw9_mp_firingrange_dummy_respawn);
  self scriptmodelclearanim();
  self.var_9a74c6fbe0cf64eb = 0;
  self solid();
  self enableaimassist();
  self.var_c284c09ef7780e64.health = function_314b6888c85326db();
  self.var_c284c09ef7780e64 setCanDamage(1);
  namespace_46e942396566f2da::function_c72573fb42d0cdbc();
}

function function_487345ce6a43a653() {
  self setCanDamage(1);
  self.owner enableaimassist();
  thread function_64289d610b532582();

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);
  }
}

function function_64289d610b532582() {
  while(true) {
    color = ter_op(self.health > 0, (0, 1, 0), (1, 0, 0));

    print3d(self.owner.origin + (0, 0, 100), int(max(self.health, 0)), color, 1, 0.75, 1, 1);

    waitframe();
  }
}

function function_b74a4c79011e5adf(primary) {
  level notify("frontend_watch_bullets");
  level endon("exit_firing_range");
  level endon("frontend_watch_bullets");

  while(true) {
    self waittill("weapon_fired", objweapon);
    bulletsfired = 0;
    hitnum = 0;

    if(objweapon == primary) {
      level.var_37a55ecaf979d920++;
      bulletsfired = level.var_37a55ecaf979d920;
      hitnum = level.var_91d278fb245d797b;

      if(function_42c8b6ff9adfabfa()) {
        level.var_b8494e78ab9bc23e++;
      }
    } else {
      level.var_febc1f5f6fc40f70++;
      bulletsfired = level.var_febc1f5f6fc40f70;
      hitnum = level.bulletshitsecondary;
    }

    thread function_af1e66cd09d0fa6f(hitnum, bulletsfired, objweapon == primary);
  }
}

function function_af1e66cd09d0fa6f(hitnum, bulletsfired, isprimary) {
  level notify("wait_for_bullet_result");
  level endon("exit_firing_range");
  level endon("wait_for_bullet_result");
  thread waitfordamage();
  level waittill_any_2("timeout_damage", "damage_done");

  if(isprimary && hitnum == level.var_91d278fb245d797b || !isprimary && hitnum == level.bulletshitsecondary) {
    bulletsfired = max(1, bulletsfired);
    accuracy = clamp(hitnum / bulletsfired, 0, 1);
    setomnvar("ui_firing_range_accuracy", accuracy);
    println("<dev string:xc6>" + accuracy);

    if(isprimary) {
      self.var_6d2bd0a2ed13ec40 = accuracy;
      self.var_a178e0e81678156e = clamp(level.var_31b6d2832a330f45 / bulletsfired, 0, 1);
    } else {
      self.var_cce2e6acbfa28188 = accuracy;
      self.var_f259c331aef28ae6 = clamp(level.var_4e5b1ceaad66b065 / bulletsfired, 0, 1);
    }

    if(isprimary && function_42c8b6ff9adfabfa()) {
      var_b8494e78ab9bc23e = max(1, level.var_b8494e78ab9bc23e);
      level.var_e89e680520310188 = clamp(level.var_6ba74ccd0535dfab / var_b8494e78ab9bc23e, 0, 1);
    }
  }
}

function waitfordamage() {
  level endon("damage_done");
  level endon("exit_firing_range");
  level endon("wait_for_bullet_result");
  wait 0.1;
  level notify("timeout_damage");
}

function isspreadweapon(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}

function spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags) {
  if(isDefined(eattacker) && isDefined(victim)) {
    hand = function_88e9e2299bd29fd1(idflags);
    victimentnum = function_d77e6b2580f74622(victim);
    time = gettime();

    if(!isDefined(eattacker.pelletweaponvictimids)) {
      eattacker.pelletweaponvictimids = [];
    }

    foreach(ihand, var_25762ef6bb7ced23 in eattacker.pelletweaponvictimids) {
      foreach(victimid, victimstruct in var_25762ef6bb7ced23) {
        if((time - victimstruct.time) / 1000 > 0.1) {
          eattacker.pelletweaponvictimids[ihand] = array_remove_key(eattacker.pelletweaponvictimids[ihand], victimid);

          if(eattacker.pelletweaponvictimids[ihand].size == 0) {
            eattacker.pelletweaponvictimids = array_remove_key(eattacker.pelletweaponvictimids, ihand);
          }
        }
      }
    }

    if(!isDefined(eattacker.pelletweaponvictimids[hand])) {
      eattacker.pelletweaponvictimids[hand] = [];
    }

    if(!isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
      eattacker.pelletweaponvictimids[hand][victimentnum] = function_c415d83582aad1e4(eattacker, objweapon, time);
    }

    eattacker.pelletweaponvictimids[hand][victimentnum].var_7981f7d372990a2b = 0;
    eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed = array_sort_with_func(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed, &is_lower);

    if(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[hand][victimentnum].var_33ac4c9665be6910) {
      if(idamage > eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0]) {
        damagedelta = idamage - eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0];
        eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0] = idamage;
        eattacker.pelletweaponvictimids[hand][victimentnum].var_7981f7d372990a2b = 1;
        idamage = damagedelta;
      } else {
        return 0;
      }
    } else {
      eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed = array_insert(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed, idamage, 0);
    }

    idamage = function_1113fc99a0327d7d(eattacker, victim, idflags, idamage);
  }

  return idamage;
}

function function_88e9e2299bd29fd1(idflags) {
  if(idflags & 2048) {
    return "lHandWeap";
  }

  return "rHandWeap";
}

function function_d77e6b2580f74622(victim) {
  return "" + victim getentitynumber();
}

function function_c415d83582aad1e4(eattacker, objweapon, time) {
  struct = spawnStruct();
  struct.time = time;
  struct.pelletdmgpassed = [];
  struct.var_9bb59738d095536e = 0;
  struct.var_33ac4c9665be6910 = getspreadpelletspershot(eattacker, objweapon);

  if(function_a062727999a72d2f(objweapon.basename)) {
    struct.var_52f16f4c9cdbf165 = 120;
  } else {
    struct.var_52f16f4c9cdbf165 = 200;
  }

  return struct;
}

function function_a062727999a72d2f(weaponname) {
  var_f8c0529126c5fb04 = ["iw9_sh_mike1014_mp", "iw9_sh_vecho_mp", "iw9_pi_swhiskey_mp"];

  foreach(i in var_f8c0529126c5fb04) {
    if(i == weaponname) {
      return true;
    }
  }

  return false;
}

function function_1113fc99a0327d7d(eattacker, victim, idflags, idamage) {
  hand = function_88e9e2299bd29fd1(idflags);
  victimentnum = function_d77e6b2580f74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids[hand]) || !isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return idamage;
  }

  var_52f16f4c9cdbf165 = eattacker.pelletweaponvictimids[hand][victimentnum].var_52f16f4c9cdbf165;
  var_9bb59738d095536e = eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e;

  if(var_9bb59738d095536e < var_52f16f4c9cdbf165) {
    idamage = clamp(idamage, 0, var_52f16f4c9cdbf165 - eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e);
    eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e += idamage;
    return idamage;
  }

  return 0;
}

function is_lower(a, b) {
  return a < b;
}

function getspreadpelletspershot(eattacker, objweapon) {
  rootname = getweaponrootname(objweapon.basename);

  if(rootname == "iw9_sh_charlie725" || rootname == "iw9_pi_swhiskey") {
    if(eattacker isdualwielding()) {
      return 2;
    }

    if(objweapon hasattachment("bar_sh_short_p14")) {
      return 3;
    }

    ads = eattacker playerads() > 0.5;

    if(ads) {
      return 4;
    } else {
      return 3;
    }

    return;
  }

  return 4;
}

function getweaponrootname(weapon) {
  if(!isDefined(level.weaponrootcache)) {
    level.weaponrootcache = [];
  }

  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    assert(isstring(weapon));
    weaponname = weapon;
  }

  cachedvalue = level.weaponrootcache[weaponname];

  if(isDefined(cachedvalue)) {
    return cachedvalue;
  }

  originalname = weaponname;
  tokens = strtok(weaponname, "_");
  index = 0;

  if(tokens[0] == "alt") {
    index++;
  }

  if(tokens[index] == "iw8" || tokens[index] == "iw9" || tokens[index] == "t10" || tokens[index] == "jup") {
    classtokens = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br"];

    if(isDefined(tokens[index + 1]) && array_contains(classtokens, tokens[index + 1])) {
      if(tokens.size >= index + 4 && tokens[index] == "t10" || tokens[index] == "jup") {
        weaponname = tokens[index] + "_" + tokens[index + 1] + "_" + tokens[index + 2] + "_" + tokens[index + 3];
      } else {
        weaponname = tokens[index] + "_" + tokens[index + 1] + "_" + tokens[index + 2];
      }
    } else {
      weaponname = tokens[index] + "_" + tokens[index + 1];
    }
  }

  if(level.weaponrootcache.size < 100) {
    level.weaponrootcache[originalname] = weaponname;
  }

  return weaponname;
}

function function_43702519a3dc0854(smeansofdeath) {
  if(!isDefined(smeansofdeath)) {
    return false;
  }

  if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
    return true;
  }

  return false;
}

function function_ae24f0c0c8c6de2a(objweapon) {
  weapontype = weaponclass(objweapon);

  if(weapontype == "sniper" && objweapon.basename != "iw9_sn_limax_mp" && getweaponhasperk(objweapon, "specialty_explosivebullet")) {
    return true;
  }

  if(objweapon.basename == "iw9_dm_crossbow_mp") {
    return true;
  }

  return false;
}

function drawsphere(origin, radius, drawtimeseconds, color) {
  drawframes = int(drawtimeseconds / 0.05);

  for(frame = 0; frame < drawframes; frame++) {
    sphere(origin, radius, color);
    waitframe();
  }
}

# /