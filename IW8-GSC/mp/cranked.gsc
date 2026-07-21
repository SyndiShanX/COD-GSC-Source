/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\cranked.gsc
***********************************************/

registercrankedtimerdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_A56611CF76F7181BE5BD95B82D4EC19B0B3592", var_1);
}

setcrankeddvarfordev() {}

makeplayercranked(var_0) {
  scripts\mp\utility\dialog::leaderdialogonplayer(var_0);
  setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
  self.cranked = 1;
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\mp\utility\perk::giveperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

oncranked(var_0, var_1, var_2) {
  if(isDefined(var_0))
    var_0 thread cleanupcrankedplayertimer();

  if(isDefined(var_1.cranked)) {
    var_3 = "_encstr_856A0D6A9001CDAFA1FEA1D61A090B";
    var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AA6F0BF1479089261FAD8CDD51");
    var_1 thread oncrankedkill(var_3);

    if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled()))
      var_1 playsoundtoplayer("_encstr_AD1D12A81A57103602A3F7E3A3C9FED00C361380", var_1);
  } else if(scripts\mp\utility\player::isreallyalive(var_1)) {
    var_1 makeplayercranked("_encstr_A9800ED8CB3867550156E23BC67AD9CB");
    var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A9800ED8CB3867550156E23BC67AD9CB");

    if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled()))
      var_1 playsoundtoplayer("_encstr_8F2918C88F993F1AEF68A84F80974FCB32BD241ECE4920D96348", var_1);
  }

  if(isDefined(var_0) && isDefined(var_0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_5 in var_0.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_5))) {
        continue;
      }
      if(var_5 == var_1) {
        continue;
      }
      if(var_0 == var_5) {
        continue;
      }
      if(!isDefined(var_5.cranked)) {
        continue;
      }
      var_5 thread oncrankedassist("_encstr_9B300F177E2B736E533F69D3910E3AB191");
      var_5 thread scripts\mp\rank::scoreeventpopup("_encstr_9B300F177E2B736E533F69D3910E3AB191");
      var_5 thread scripts\mp\rank::scoreeventpopup("_encstr_AA6F0BF1479089261FAD8CDD51");

      if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled()))
        var_5 playsoundtoplayer("_encstr_AD1D12A81A57103602A3F7E3A3C9FED00C361380", var_5);
    }
  }
}

_id_1200C(var_0) {
  if(self == var_0) {
    return;
  }
  setcrankedplayerbombtimer("_encstr_BD1904D06B18");
}

cleanupcrankedplayertimer() {
  self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
  thread waitthenstopcrankedbombtimer();
}

waitthenstopcrankedbombtimer() {
  waitframe();
  self notify("_encstr_9B8E0DAE0BE2F1E66BCBF080478559");
}

oncrankedkill(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers))
    waitframe();

  setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
}

oncrankedassist(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  setcrankedplayerbombtimer("_encstr_A1BD075837DCD29B47");
}

setcrankedplayerbombtimer(var_0) {
  var_1 = level.crankedbombtimer;
  var_2 = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_959105B99040BD" || scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C")
    var_2 = 1;

  if(var_0 == "_encstr_BD1904D06B18") {
    var_1 = int((self.cranked_end_time - gettime()) / 1000 + 1);

    if(var_1 > level.crankedbombtimer)
      var_1 = level.crankedbombtimer;
  } else if(var_0 == "_encstr_A1BD075837DCD29B47") {
    if(var_2)
      var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
    else
      var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  } else if(var_0 == "_encstr_97840D618B0F15D087F46337F42E50")
    var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
  else if(var_2) {
    if(isDefined(self.cranked) && self.cranked && isDefined(self.cranked_end_time))
      var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    else
      var_1 = int(var_1 * 0.5);
  } else
    var_1 = level.crankedbombtimer;

  var_3 = var_1 * 1000 + gettime();
  self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", var_3);
  self.cranked_end_time = var_3;
  thread watchcrankedplayerhostmigration();
  thread watchcrankedbombtimer(var_1);
  thread watchcrankedendgame();
}

watchcrankedplayerhostmigration() {
  self notify("_encstr_AF911A1F91F3F0D3EFFBF9CD722F9DE14DFB91F3319FA0AFDB623008");
  self endon("_encstr_AF911A1F91F3F0D3EFFBF9CD722F9DE14DFB91F3319FA0AFDB623008");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B8E0DAE0BE2F1E66BCBF080478559");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_0 > 0)
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", self.cranked_end_time + var_0);
  else
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", self.cranked_end_time);
}

watchcrankedendgame() {
  self notify("_encstr_AA470D6B3125AF3C01ED5C078B3807");
  self endon("_encstr_AA470D6B3125AF3C01ED5C078B3807");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B8E0DAE0BE2F1E66BCBF080478559");

  for(;;) {
    if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" || level.gameended) {
      self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
      break;
    }

    wait 0.1;
  }
}

watchcrankedbombtimer(var_0) {
  self notify("_encstr_97CE0FD3A849463BDD38E5E25D40D70FAD");
  self endon("_encstr_97CE0FD3A849463BDD38E5E25D40D70FAD");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9B8E0DAE0BE2F1E66BCBF080478559");
  thread infectparachuteheightoffset(var_0);
  var_1 = 5;
  var_2 = var_0 - var_1 - 1;

  if(var_2 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(var_2);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
  }

  while(var_1 > 0) {
    self playsoundtoplayer("_encstr_99B8144DEBC16583E821734AA8DAEF9F6949D9AD1B70", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self) && scripts\mp\utility\game::getgametype() != "_encstr_85EF050CB150E7") {
    self playSound("_encstr_A2D710230D27839761101B53117B721AC59E");
    var_3 = self.origin + (0, 0, 32);
    playFX(level._effect["_encstr_8EF3100682106612B5B58F5F28607CB76B38"], var_3);
    scripts\mp\utility\damage::_suicide();
    self radiusdamage(var_3, 256, 200, 100, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);

    if(scripts\cp_mp\utility\player_utility::_isalive())
      self dodamage(self.maxhealth, var_3, self, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
  }
}

infectparachuteheightoffset(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA4819F24BB01A1F3698A88381806F97F843B158FD50E79BD513A3");
  self endon("_encstr_BA4819F24BB01A1F3698A88381806F97F843B158FD50E79BD513A3");
  var_1 = 0;
  var_2 = 0;

  if(var_0 != level.crankedbombtimer)
    var_1 = level.crankedbombtimer - var_0;

  while(isalive(self)) {
    var_1 = var_1 + 0.05;
    var_3 = clamp(1.0 - var_1 / level.crankedbombtimer, 0.0, 1.0);
    self setclientomnvar("_encstr_834C165D2DBE1BE40B9BB52B19EBC4F65B89FA1DB4B6564E", var_3);
    wait 0.05;
  }
}