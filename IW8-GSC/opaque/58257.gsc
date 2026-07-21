/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58257.gsc
***********************************************/

vehicle_compass_setteamfriendlyto() {
  level.vehicle_damage_cp_init = [];
  level.vehicle_damage_applytabletovehicle = getdvarint("_encstr_95FD169B6C93D75358DAD6569C7DB6853C7D869558D8D11A", 150);
  level.vehicle_damage_beginburndown = getdvarint("_encstr_BA1812835F0501905BFAF74AD22FDBA8F0599B8F", 1750);
  level.vehicle_damage_deregisterdefaultvisuals = getdvarfloat("_encstr_A73A206ED893AF4D0BB5AD2B27FAEAB4BE398519D2ABCDAFADD51B3AB4E01B5A5627", 1);
  level.vehicle_createspawnselectiontankmarker = getdvarint("_encstr_85C8143EEB436645CE4AC880936911F87B95C5BB4DA7", 45);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84B814D40BDADAB2C9D795DCCAB62FFA37BDD196CCBC"] = "_encstr_AD4514B228B84BB5B3D7B3AA9A11A2E0E010C49775FF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8106139A298FD8D3DBD9093511C916A69FEBE455E9"] = "_encstr_8C57174D2C5B6B95C9FA669C5AACE623D85E7DDEE6D8A5DC59";
}

vehicle_compass_init() {
  var_0 = 0;

  foreach(var_2 in level.vehicle_damage_cp_init) {
    foreach(var_4 in var_2) {
      var_0++;

      if(var_0 >= getdvarint("_encstr_B1ED139F728A6ED0E70AC373C381D83ED907405B7D", 20))
        return 0;
    }
  }

  return 1;
}

vehicle_compass_instanceisregistered(var_0) {
  if(!vehicle_compass_init()) {
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    scripts\mp\hud_message::showerrormessage("_encstr_A3D6216AA0FA2194EB2593A305352AAF8AAAAFEA966699A9CB52A035355129F5A614B0");

    if(isDefined(self.super))
      _encstr_84F913A0779D4023C309EE7D5FEB6D29EB5FF84093();

    var_0 delete();
    return;
  }

  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_1.model) && (var_1.model == "_encstr_921821C9DDA16923234FA3DB7BC3184058AF56CACFC05520AFE86F21A980137EA3C795" || var_1.model == "_encstr_AAD31BDAD21B2D3AB09CF2D7D8C29C953858B1B6859D95BE0C8CEB26C9")) {
      self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
      scripts\mp\hud_message::showerrormessage("_encstr_8FC82AA641BE2425BE92E43A286A51BE8A55AF75B433D08197492853A6A2497DD00A27C9F48AAF41310AD015");

      if(isDefined(self.super))
        _encstr_84F913A0779D4023C309EE7D5FEB6D29EB5FF84093();

      var_0 delete();
      return;
    }
  }

  vehicle_compass_infect_shouldbevisibletoplayer(self, var_0);
  var_0.owner = self;
  var_0.headicon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 8);
  var_2 = getgroundposition(self.origin, 1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_0.scrambleent = var_3;
  var_0.scrambleent.owner = self;
  var_0.scrambleent.team = self.team;
  var_0.scrambleent setotherent(self);
  var_3 makescrambler(self);
  var_0 unmarkkeyframedmover(1);
  var_0.scrambleent linkTo(var_0);
  var_0.issuper = 1;
  var_0 enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");

  if(level.teambased)
    var_0 filteroutplayermarks(self.team);
  else
    var_0 filteroutplayermarks(self);

  scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_87560DB2E25D2D07EB4D85B5D65693", ::vehicle_compass_mp_shouldbevisibletoplayer);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread vehicle_compass_mp_init(self);
  var_0 thread scripts\mp\equipment_interact::remoteinteractsetup(::vehicle_compass_mp_shouldbevisibletoplayer, 1, 1);
  var_0 thread vehicle_cp_deletenextframe();
  var_0 thread vehicle_cp_deletenextframelate();
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_encstr_8B7E12A916B66B599CFA95AD38160E1CB15A2B19);
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A7C5056BD931D1", 0);
  var_4 = scripts\mp\utility\player::getplayersinradius(self.origin, level.vehicle_damage_beginburndown + 2953);

  foreach(var_6 in var_4) {
    if(var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      continue;
    }
    if(var_6.team == self.team) {
      if(var_6 == self)
        continue;
      else {
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8106139A298FD8D3DBD9093511C916A69FEBE455E9", var_6, 1, 0, 0.5);
        continue;
      }
    }

    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_84B814D40BDADAB2C9D795DCCAB62FFA37BDD196CCBC", var_6, 1, 0, 0.5);
  }

  var_0.scrambleent thread vehicle_createlate(self);
}

vehicle_cp_deletenextframelate() {
  self endon("_encstr_AD75063D571AE108");
  wait(level.vehicle_createspawnselectiontankmarker);
  vehicle_compass_mp_shouldbevisibletoplayer();
}

vehicle_cp_deletenextframe() {
  self endon("_encstr_AD75063D571AE108");
  self.scrambleent.owner scripts\engine\utility::_id_143A7("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_9B1D0BC7932875276230426AA1");
  vehicle_compass_mp_shouldbevisibletoplayer();
}

vehicle_compass_playerspawnedcallback() {}

vehicle_cp_create() {}

vehicle_compass_mp_init(var_0) {
  scripts\mp\damage::monitordamage(level.vehicle_damage_applytabletovehicle, "_encstr_A2FB098A2035874AB0F358", ::vehicle_compass_setplayerfriendlyto, ::vehicle_compass_show, 0);
}

vehicle_compass_show(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  var_5 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_2, var_3, var_5);
  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_5;
}

vehicle_compass_setplayerfriendlyto(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
    var_2 = self.owner getentitynumber();

    if(level.vehicle_damage_cp_init[var_2].size > 1)
      self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_88960F4D16AF192B6E47937B972BC8F5B6");
    else
      self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AA960F3516D7232B9BD127F6F2AC23BE9B");
  }

  vehicle_compass_mp_shouldbevisibletoplayer();
}

vehicle_compass_mp_shouldbevisibletoplayer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.owner notify("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");

  if(isDefined(self.owner))
    vehicle_compass_updatevisibilityforallplayers(self.owner, self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);

  if(isDefined(self.scrambleent)) {
    self.scrambleent vehicle_compass_playerjoinedteamcallback();
    self.scrambleent clearscrambler();
    self.scrambleent delete();
  }

  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8D31132C1B3AA567CA88B2B93A4E7BE56A1D85278E", 0);
  wait 1;

  if(isDefined(self)) {
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
    earthquake(0.5, 1, self.origin, 512);
  }

  wait 1.5;
  self delete();
}

_encstr_8B7E12A916B66B599CFA95AD38160E1CB15A2B19(var_0) {
  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker))) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BABE10CAB51CFA0E5693DCBD37FAE6E8EA73"), var_0.victim, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    vehicle_compass_setplayerfriendlyto(var_0);
  }
}

vehicle_createlate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BEBD1803B60278C15A33432F57F39790BA0129D89D71B00B02FB");

  if(!isDefined(var_0))
    var_0 = self.owner;

  self.enemiesaffectedbyscambler = [];
  var_1 = 0;
  var_2 = level.vehicle_damage_beginburndown;
  var_3 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);

  for(;;) {
    var_4 = self.origin;
    var_5 = (var_2, var_2, 3000);
    var_6 = var_4 - var_5;
    var_7 = var_4 + var_5;
    var_8 = physics_aabbbroadphasequery(var_6, var_7, var_3, []);

    foreach(var_10 in var_8) {
      if(isPlayer(var_10)) {
        var_11 = var_10;
        var_12 = 0;
        var_13 = distance2dsquared(self.origin, var_11.origin);
        var_14 = var_2 * var_2;

        if(isDefined(var_11) && var_13 < var_14 && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
          if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" || !level.teambased && var_11 != self.owner) {
            if(var_11 scripts\cp_mp\utility\player_utility::isusingremote()) {
              continue;
            }
            if(var_11 _id_124C3(self)) {
              continue;
            }
            var_11 vehicle_compass_updatevisibilityforplayer(1, self, var_1);
            var_11.useautorespawn = 1;
            continue;
          }

          if(var_11 _id_124C3(self))
            var_11 vehicle_compass_updatevisibilityforplayer(0, self, var_1);
        }
      }
    }

    foreach(var_17 in self.enemiesaffectedbyscambler) {
      if(!scripts\engine\utility::array_contains(var_8, var_17)) {
        if(var_17 _id_124C3(self))
          var_17 vehicle_compass_updatevisibilityforplayer(0, self, var_1);
      }
    }

    waitframe();
  }
}

vehicle_compass_registerinstance(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_5 in level.supportdrones) {
      if(var_5.helperdronetype != "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
        continue;
      }
      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team)
          var_3 = var_5.friendliesaffectedbyscrambler;
        else
          var_3 = var_5.enemiesaffectedbyscambler;
      } else if(!isDefined(var_1) && var_5.owner == self)
        var_3 = var_5.friendliesaffectedbyscrambler;
      else
        var_3 = var_5.enemiesaffectedbyscambler;

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.size > 0) {
        foreach(var_7 in var_3) {
          if(self == var_7 || isDefined(var_7.owner) && self == var_7.owner) {
            var_2 = 1;
            break;
          }
        }

        if(istrue(var_2)) {
          break;
        }
      }
    }
  }

  return var_2;
}

vehicle_compass_updatevisibilityforplayer(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    if(!scripts\engine\utility::array_contains(var_1.enemiesaffectedbyscambler, var_3))
      var_1.enemiesaffectedbyscambler[var_1.enemiesaffectedbyscambler.size] = var_3;

    if(!isDefined(var_3.scrambledby)) {
      var_3.scrambledby = [var_1];
      var_3 thread vehicle_create();
    } else
      var_3.scrambledby[var_3.scrambledby.size] = var_1;

    var_3 thread vehicle_compass_shouldbevisibletoplayer(var_1, var_2);
  } else if(isDefined(var_3)) {
    if(scripts\engine\utility::array_contains(var_1.enemiesaffectedbyscambler, var_3))
      var_1.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var_1.enemiesaffectedbyscambler, var_3);
    else
      var_1.enemiesaffectedbyscambler = scripts\engine\utility::array_removeundefined(var_1.enemiesaffectedbyscambler);

    var_3.scrambledby = scripts\engine\utility::array_remove(var_3.scrambledby, var_1);

    if(var_3.scrambledby.size == 0) {
      var_3.scrambledby = undefined;
      var_3 _encstr_921E15B9D1DBC1D7D42CD6B5B293EB9B36932C5B891B2B(var_3.currentscramblerstrength);
      var_3.previousscramblerstrength = undefined;
      var_3.currentscramblerstrength = undefined;
      var_3.useautorespawn = 0;
      var_3 notify("_encstr_A7F40E2F6B5A936FF693079A49378176");
    }
  }
}

vehicle_compass_shouldbevisibletoplayer(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_9AEB0D0BBFE82637B68DC269489C23");

  if(_id_124C3(var_0)) {
    if(isDefined(self)) {
      if(isDefined(var_0) && isDefined(var_0.enemiesaffectedbyscambler))
        var_0.enemiesaffectedbyscambler = scripts\engine\utility::array_remove(var_0.enemiesaffectedbyscambler, self);
    }

    vehicle_compass_updatevisibilityforplayer(0, var_0, var_1);
  }
}

_id_124C3(var_0) {
  return isDefined(self.scrambledby) && scripts\engine\utility::array_contains(self.scrambledby, var_0);
}

vehicle_create(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9AEB0D0BBFE82637B68DC269489C23");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.vehicle_damage_beginburndown;
  var_4 = var_3 * var_3;

  for(;;) {
    if(!isDefined(self.scrambledby)) {
      return;
    }
    foreach(var_6 in self.scrambledby) {
      var_7 = distance2dsquared(var_6.origin, self.origin);
      level.loot_setitemcount = var_7;
      var_8 = 0;
      var_2 = 0;

      if(var_7 > var_4)
        var_8 = 0;
      else if(var_7 >= var_4 * 0.8)
        var_8 = 1;
      else if(var_7 >= var_4 * 0.6)
        var_8 = 2;
      else if(var_7 >= var_4 * 0.4)
        var_8 = 3;
      else if(var_7 >= var_4 * 0.2)
        var_8 = 4;
      else
        var_8 = 5;

      if(var_8 > var_2)
        var_2 = var_8;
    }

    if(var_1 == 0 || var_2 != var_1) {
      self.previousscramblerstrength = var_1;
      self.currentscramblerstrength = var_2;

      if(self.previousscramblerstrength > 1)
        var_10 = self.previousscramblerstrength;

      if(self.currentscramblerstrength > 1)
        var_10 = self.currentscramblerstrength;

      _encstr_921E15B9D1DBC1D7D42CD6B5B293EB9B36932C5B891B2B(var_1);
      _encstr_8AD315A2A5F13829FA879788BD6D2847EA9BE7BAE27093(var_2);
      var_1 = var_2;
    }

    wait 1;
  }
}

vehicle_compass_playerjoinedteamcallback() {
  self notify("_encstr_BEBD1803B60278C15A33432F57F39790BA0129D89D71B00B02FB");

  if(isDefined(self.enemiesaffectedbyscambler) && self.enemiesaffectedbyscambler.size > 0) {
    foreach(var_1 in self.enemiesaffectedbyscambler) {
      if(isDefined(var_1)) {
        var_2 = var_1;

        if(isDefined(var_2.owner))
          var_2 = var_2.owner;

        if(var_2 _id_124C3(self))
          var_2 vehicle_compass_updatevisibilityforplayer(0, self);
      }
    }
  }
}

vehicle_compass_updatevisibilityforallplayers(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = [];

  for(var_4 = 0; var_4 < level.vehicle_damage_cp_init[var_2].size; var_4++) {
    var_5 = level.vehicle_damage_cp_init[var_2][var_4];

    if(var_5 != var_1)
      var_3[var_3.size] = var_5;
  }

  level.vehicle_damage_cp_init[var_2] = var_3;
}

vehicle_compass_infect_shouldbevisibletoplayer(var_0, var_1) {
  var_2 = var_0 getentitynumber();

  if(!isDefined(level.vehicle_damage_cp_init[var_2]))
    level.vehicle_damage_cp_init[var_2] = [];

  var_3 = level.vehicle_damage_cp_init[var_2].size;

  if(var_3 + 1 > 1) {
    level.vehicle_damage_cp_init[var_2][0] vehicle_compass_mp_shouldbevisibletoplayer();
    var_3--;
  }

  level.vehicle_damage_cp_init[var_2][var_3] = var_1;
}

vehicle_compass_updateallvisibilityforplayer(var_0) {
  vehicle_compass_updatevisibilityforallplayers(var_0, self);
  vehicle_compass_infect_shouldbevisibletoplayer(self.owner, self);
  self.scrambleent.team = self.owner.team;
  self.scrambleent makescrambler(self.owner);
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_930B07BB1B6B3854FF", 0);
}

_encstr_8AD315A2A5F13829FA879788BD6D2847EA9BE7BAE27093(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(!isDefined(self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842))
    self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842 = [];

  var_1 = self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0];

  if(!isDefined(var_1))
    var_1 = 0;

  self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0] = var_1 + 1;
  _encstr_83C8189E23B35D607B05E78529655895D3F99381FB4F01B0951D();
}

_encstr_921E15B9D1DBC1D7D42CD6B5B293EB9B36932C5B891B2B(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(isDefined(self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0])) {
    self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0] = self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0] - 1;

    if(self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0] == 0)
      self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842[var_0] = undefined;
  }

  _encstr_83C8189E23B35D607B05E78529655895D3F99381FB4F01B0951D();
}

_encstr_83C8189E23B35D607B05E78529655895D3F99381FB4F01B0951D() {
  var_0 = 0;

  foreach(var_3, var_2 in self._encstr_9724158A2388BD7FD69BCA2321A1AB3510913D1EB3E842) {
    if(var_3 > var_0)
      var_0 = var_3;
  }

  self setclientomnvar("_encstr_9A53136BA44723DA4D2287E357A34B6BDF65EACB69", var_0);
}

_encstr_84F913A0779D4023C309EE7D5FEB6D29EB5FF84093() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");
  self notify("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12097(self.super, 1);
  var_0 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::_id_131C7(0);
  scripts\mp\supers::_id_131C6(0);
  var_0.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}