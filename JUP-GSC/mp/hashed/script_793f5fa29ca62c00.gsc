/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_793f5fa29ca62c00.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_1feb0785278dafea;
#using script_220d0eb95a8fab7d;
#using script_23b580b08abe064f;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5640d32580c6bc7d;
#using script_638d701d263ee1ed;
#using script_7956d56c4922bd1;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace namespace_84e2a73178a22f53;

function function_58fb23fc08762d69() {
  function_89384091f7a2dbd("REV_OB_DOGHOUSE", 0, &function_a4b356741a6dc247);
  function_89384091f7a2dbd("REV_OB_DOGHOUSE", 1, &function_a5e0e239dcfccadf);
  function_89384091f7a2dbd("REV_OB_DOGHOUSE", 2, &function_1412c4d46e3a5716);
  function_89384091f7a2dbd("REV_OB_DOGHOUSE", 3, &function_f01338be1f454544);
  function_89384091f7a2dbd("REV_OB_DOGHOUSE", 5, &function_db162e424573ba18);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_a154bc41f62b9a41, "REV_OB_DOGHOUSE");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5f08e5ac1feea611, "REV_OB_DOGHOUSE");
  callback::add("on_used_super", &function_a5e16566a91e9488);
}

function function_a4b356741a6dc247() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_45c17c8bd7095cc4 = function_b9c4aa88ad97ee68(self);
  self.variant_definition = var_45c17c8bd7095cc4;
  self.var_ed227a1f2b382bbc = self.variant_definition.var_1235584cb7528cff;
  self.difficulty_region = function_415547ee4122c2ca();
  self.var_1f0f8351395d38ff = 1;

  switch (self.difficulty_region) {
    case #"hash_7bb2cd766703d463":
      self.var_1f0f8351395d38ff = self.variant_definition.greenchunks;
      break;
    case #"hash_af83e47edfa8900a":
      self.var_1f0f8351395d38ff = self.variant_definition.yellowchunks;
      break;
    case #"hash_5343b465e56ec9a4":
      self.var_1f0f8351395d38ff = self.variant_definition.orangechunks;
      break;
    case #"hash_651f76c0ad6741ec":
      self.var_1f0f8351395d38ff = self.variant_definition.redchunks;
      break;
    default:
      self.var_1f0f8351395d38ff = self.variant_definition.greenchunks;
      break;
  }

  self.var_9572775c8f8e6cc5 = getscriptbundle("itemspawnentry:" + self.var_ed227a1f2b382bbc);
  self.chunk_lootid = function_6d15e119c2779a93(self.var_9572775c8f8e6cc5);
  var_3d949bb4e4d7879 = getStructArray(self.varianttag, "target");
  self.doghouse_struct = undefined;

  foreach(struct in var_3d949bb4e4d7879) {
    if(isDefined(struct.targetname)) {
      switch (struct.targetname) {
        case #"hash_26963cc17eadad19":
          self.doghouse_struct = struct;
          break;
      }
    }
  }

  self.doghouse = spawn_model("jup_zm_dog_house", self.doghouse_struct.origin, self.doghouse_struct.angles);
  function_d7e6bfae24fb99c9();
  self.doghouse setscriptablepartstate("doghouse_vfx", "idle");
}

function function_d7e6bfae24fb99c9() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body_doghouse", &function_cf1b1f86951a9209);
  scripts\engine\utility::flag_wait("scriptables_ready");
  instance = self.doghouse getlinkedscriptableinstance();
  instance.varianttag = self.varianttag;
  instance.activity_instance = self;
  instance callback::add("on_cache_closed", &function_378db8dafafcc467);
  self.doghouse setscriptablepartstate("body_doghouse", "closed_usable");
  instance.var_55bb3585d29af1be = &function_d58f3859f6db61b9;
  var_4bb87eb4d1bbfcce = &function_9faebc80649d0947;
  instance.noweaponslot = !getdvarint(@ "hash_f09fed6023f0158b", 0);
  instance.var_532eac3c428e5b9b = 1;
  instance.containertype = 17;
}

function function_d58f3859f6db61b9(instance, player) {
  if(instance.activity_instance.state == "IdleState") {
    function_b6fc2c96b463c007(instance.activity_instance);
  }

  if(instance.activity_instance.doghouse getscriptablepartstate("body_doghouse") != "partially_open_in_use_unusable") {
    instance.activity_instance.doghouse setscriptablepartstate("body_doghouse", "partially_open_in_use_unusable");
  }
}

function function_9faebc80649d0947(container, player, lootid, quantity, itemtype, itemindex) {
  noextract = undefined;
  backpackquantity = quantity;

  if(isDefined(itemtype) && itemtype == 10) {
    backpackquantity = scripts\cp_mp\loot\common_cache::function_8e5978971b5dcd16(player, itemindex);
  }

  if(!isDefined(itemtype)) {
    itemtype = 0;
  }

  if(!isDefined(itemindex)) {
    itemindex = 0;
  }

  player notify("item_added_to_cache", itemtype, itemindex, lootid, backpackquantity);
  return [lootid, noextract];
}

function function_378db8dafafcc467(params) {
  opener = params.opener;
  container = self;

  foreach(player in container.playeropen) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.var_4e300028cc830f21)) {
      player.var_4e300028cc830f21[self.varianttag] = 0;
    }

    if(!isDefined(player.var_4e300028cc830f21[self.varianttag])) {
      player.var_4e300028cc830f21[self.varianttag] = 0;
    }

    var_e94b4ab20232f72a = 0;
    var_2cf547fdc2dcf36c = 0;
    emptycontainer = 1;
    var_e1cf43f3ae9d77e7 = container.contents;

    foreach(index, item in var_e1cf43f3ae9d77e7) {
      if(!isDefined(item.lootid) || item.lootid == 0) {
        continue;
      }

      bundlename = function_fc925a153c7fd55c(item.lootid);
      itembundle = getscriptbundle("itemspawnentry:" + bundlename);
      scriptablename = itembundle.scriptable;
      itemtype = itembundle.type;

      if(item.lootid != 0 && item.lootid != self.activity_instance.chunk_lootid) {
        var_2cf547fdc2dcf36c = 1;
        emptycontainer = 0;

        if((item.lootid == function_2c836ad05e5f634c("equip_molotov") || item.lootid == function_2c836ad05e5f634c("equip_thermite")) && isDefined(level.var_d0ae7d85b0070ba0) && [[level.var_d0ae7d85b0070ba0]](player)) {
          var_5d27a018f76255ac = 1;
        }
      } else {
        var_e94b4ab20232f72a++;
        emptycontainer = 0;
      }

      if(!istrue(container.contents[index].noextract)) {
        container.contents[index].lootid = 0;
        container.contents[index].quantity = 0;
      }
    }

    if(emptycontainer && self.activity_instance.doghouse isscriptable()) {
      self.activity_instance.doghouse setscriptablepartstate("body_doghouse", "closed_usable");
      return;
    }

    if(var_2cf547fdc2dcf36c) {
      self.activity_instance function_f4f8643f5705b2d8(player, var_5d27a018f76255ac);
      continue;
    }

    player.var_4e300028cc830f21[self.varianttag] += var_e94b4ab20232f72a;
    function_51ef0f6208c80764(player);
  }
}

function function_51ef0f6208c80764(player) {
  if(player.var_4e300028cc830f21[self.varianttag] >= self.activity_instance.var_1f0f8351395d38ff) {
    self.activity_instance function_ea4997f9940f6e9d(player);
    return;
  }

  if(isDefined(self) && isDefined(self.activity_instance) && self.activity_instance.doghouse isscriptable()) {
    self.activity_instance.doghouse setscriptablepartstate("doghouse_sfx", "play_eat");
    self.activity_instance.doghouse setscriptablepartstate("body_doghouse", "closed_usable");
  }
}

function function_a5e0e239dcfccadf() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
}

function function_ea4997f9940f6e9d(player) {
  level endon("game_ended");
  self.doghouse setscriptablepartstate("doghouse_vfx_2", "success");
  wait 1;
  self.doghouse setscriptablepartstate("body_doghouse", "ended");
  self.doghouse setModel("tag_origin");
  function_93c37ea2b2745734(player, self.doghouse_struct);

  if(!function_4ab1cdfd84bbd3f2(self, player)) {
    function_bbdcd857d0c2a65e(self, player, "PlayerJoinedInteract");
  }

  endactivity(self, 1);
}

function function_93c37ea2b2745734(player, spawn_struct, var_afe6f9511d9e590b) {
  var_afe6f9511d9e590b = default_to(var_afe6f9511d9e590b, 0);

  if(isalive(player)) {
    if(isDefined(player.var_c5668dcaf32afbc3)) {
      player.var_c5668dcaf32afbc3 kill();
    }

    aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_hellhound_pet")[0];
    hound = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype, spawn_struct.origin, spawn_struct.angles, player.team);

    if(isalive(hound)) {
      hound function_ca27630def7b7aad(player);
      hound function_534261879df56014(&namespace_f585f5e438cbdbc8::heal_player);
      hound function_18ef53f39e80bc9b(&function_73ee7ac93e75b59c);
      hound function_d684067ff5d4c744(&function_ec0edea55cdeb109);
      hound function_90d0e1682e0a56b6(&function_3c10d5b169a1bb6f);
      hound function_47090d2d7a24baed(&function_c82c562c66708025);
      hound namespace_99b160f0b52a4db::function_26c99e23305fecac(player, var_afe6f9511d9e590b);
      hound setthreatbiasgroup("team_players");
      hound.var_a32530404b862f7b = 1;
      hound.headicon = createheadicon(hound);
      setheadiconimage(hound.headicon, "ui_jup_hud_hacking_complete_border");
      setheadicondrawinmap(hound.headicon, 1);
      setheadiconzoffset(hound.headicon, 20);
      function_51044b10b2b673df(hound.headicon, "icon_small");
      return hound;
    }
  }
}

function function_a5e16566a91e9488(params) {
  if(isPlayer(params.player) && isDefined(params.superinfo)) {
    if(params.superinfo.staticdata.ref == "super_healing_aura") {
      if(isDefined(self.var_c5668dcaf32afbc3) && isalive(self.var_c5668dcaf32afbc3)) {
        self.var_c5668dcaf32afbc3.health = int(min(self.var_c5668dcaf32afbc3.maxhealth, self.var_c5668dcaf32afbc3.health + int(self.var_c5668dcaf32afbc3.maxhealth * 0.25)));
      }
    }
  }
}

function function_90d0e1682e0a56b6(var_5d5824dc31b9d955) {
  self.var_182bc385bd9c0c1d = var_5d5824dc31b9d955;
}

function function_d684067ff5d4c744(melee_fn) {
  self.var_e6e13802782ceaf1 = melee_fn;
}

function function_ec0edea55cdeb109() {
  if(isDefined(self.enemy)) {
    if(isPlayer(self.enemy)) {
      self.melee_damage = getdvarint(@ "hash_57d855b79b4433b6", 30);
      return;
    }

    var_ce3a893d4aa3d447 = 0;

    switch (self.enemy.subclass) {
      case #"hash_91cd18ea8bf6d95":
      case #"hash_1380581f5144c465":
      case #"hash_93b4f38d9787d026":
      case #"hash_99a38be9e88b5244":
      case #"hash_b668d02ebeae46bb":
      case #"hash_f297af39454fdc7b":
        var_ce3a893d4aa3d447 = 1;
        break;
      default:
        break;
    }

    if(var_ce3a893d4aa3d447) {
      self.var_dec41e66d2f7fffd = self.enemy.maxhealth;
      return;
    }

    if(isDefined(self.enemy.difficulty)) {
      switch (self.enemy.difficulty) {
        case #"hash_7bb2cd766703d463":
          self.var_dec41e66d2f7fffd = 250;
          break;
        case #"hash_af83e47edfa8900a":
          self.var_dec41e66d2f7fffd = 1500;
          break;
        case #"hash_5343b465e56ec9a4":
          self.var_dec41e66d2f7fffd = 10000;
          break;
        case #"hash_651f76c0ad6741ec":
          self.var_dec41e66d2f7fffd = 20000;
          break;
        default:
          self.var_dec41e66d2f7fffd = 250;
          break;
      }

      return;
    }

    self.var_dec41e66d2f7fffd = 250;
  }
}

function function_73ee7ac93e75b59c(var_afe6f9511d9e590b) {
  if(istrue(var_afe6f9511d9e590b)) {
    namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
    scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677b73b07d385d", 30000));
    self.health = self.maxhealth;
    return;
  }

  difficulty_region = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.origin);

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    difficulty_region = "difficulty_easy";
  }

  switch (difficulty_region) {
    case #"hash_7bb2cd766703d463":
      scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677973b07d33f7", 7500));
      break;
    case #"hash_af83e47edfa8900a":
      scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677a73b07d362a", 18000));
      break;
    case #"hash_5343b465e56ec9a4":
      scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677b73b07d385d", 30000));
      break;
    case #"hash_651f76c0ad6741ec":
      scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677473b07d28f8", 45000));
      break;
    default:
      scripts\common\ai::function_dd21d67ede8ba22(getdvarint(@ "hash_bb677973b07d33f7", 7500));
      break;
  }

  self.health = self.maxhealth;
}

function function_18ef53f39e80bc9b(health_fn) {
  self.var_ec1d59ad9332c4c3 = health_fn;
}

function private function_534261879df56014(heal_fn) {
  self.var_f781c4947731680f = heal_fn;
}

function private function_47090d2d7a24baed(var_8998b4ac2687fb35) {
  self.var_8998b4ac2687fb35 = var_8998b4ac2687fb35;
}

function function_c82c562c66708025(backward_origin, n_damage) {
  level endon("game_ended");
  self endon("death");
  counter = 0;

  while(true) {
    if(counter >= 60) {
      if(isDefined(n_damage)) {
        self dodamage(n_damage, self.origin, undefined, undefined, "MOD_IMPACT");
      }

      return;
    }

    var_74d42ff7c5fbd256 = getgroundposition(self.origin, 1)[2];
    backward_origin = (backward_origin[0], backward_origin[1], self.origin[2] - 150);
    current_origin = vectorlerp(self.origin, backward_origin, counter / 60);

    if(current_origin[2] > var_74d42ff7c5fbd256) {
      self forceteleport(current_origin);
    } else {
      if(isDefined(n_damage)) {
        self dodamage(n_damage, self.origin, undefined, undefined, "MOD_IMPACT");
      }

      return;
    }

    counter++;
    waitframe();
  }
}

function function_f4f8643f5705b2d8(player, var_5d27a018f76255ac) {
  level endon("game_ended");
  self.doghouse setscriptablepartstate("doghouse_vfx_2", "failure");
  wait 1;
  self.doghouse setscriptablepartstate("body_doghouse", "ended");
  self.doghouse setModel("tag_origin");
  aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_hellhound")[0];
  var_d2dc53d5b262c23a = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype, self.doghouse_struct.origin, self.doghouse_struct.angles, "team_two_hundred");
  var_d2dc53d5b262c23a namespace_dd16d65e824b8e9::function_a047f71d0256058b(player);

  if(istrue(var_5d27a018f76255ac)) {
    level thread function_fb60235e11c3193a(var_d2dc53d5b262c23a, player);
  }

  endactivity(self, 0);
}

function private function_fb60235e11c3193a(var_d2dc53d5b262c23a, player) {
  var_d2dc53d5b262c23a waittill("death");

  if(isDefined(player)) {
    itembundlename = "ob_jup_item_key_rift_gate_season1_fire";
    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    payload = [#"teamselect", player getentitynumber()];
    a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, var_d2dc53d5b262c23a.origin, undefined, 0, 1, payload);

    if(isDefined(item)) {
      params = spawnStruct();
      params.item = item;
      params.itembundlename = itembundlename;
      params.payload = payload;

      if(isDefined(level.var_8b939fbe0ef2d56b)) {
        player[[level.var_8b939fbe0ef2d56b]](params);
      }

      thread scripts\cp_mp\overlord::playevent("quest_s1_rift_gate_unlock_object_acquired", a_squad, 1.5);
    }
  }
}

function function_415547ee4122c2ca() {
  difficulty_region = undefined;

  if(isDefined(level.var_fac39a693f085779)) {
    difficulty_region = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(self));
  }

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_1412c4d46e3a5716(activity_succeeded) {
  activity_instance = self;
  activity_instance endon("instance_destroyed");

  foreach(player in level.players) {
    if(isDefined(player.var_4e300028cc830f21) && isDefined(player.var_4e300028cc830f21[self.varianttag])) {
      player.var_4e300028cc830f21[self.varianttag] = undefined;
    }
  }
}

function function_f01338be1f454544() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");

  if(isDefined(self.doghouse)) {
    level notify("forced_kill_callout_" + self.doghouse.origin);
    self.doghouse delete();
  }
}

function function_403ee5a202f042df() {
  return self.doghouse.origin;
}

function function_db162e424573ba18() {
  var_cc7aa96a854fd8ee = spawnStruct();
  var_cc7aa96a854fd8ee.origin = (0, 0, 0);
  var_cc7aa96a854fd8ee.angles = (0, 0, 0);
}

function function_a154bc41f62b9a41(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.var_b494ea8c4b70490;
}

function function_5f08e5ac1feea611(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
}