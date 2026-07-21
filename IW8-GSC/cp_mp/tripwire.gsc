/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\tripwire.gsc
***********************************************/

precache(var_0, var_1) {
  if(!isDefined(level.tripwires)) {
    tripwiremodelprecache();
    spawntripwirelevelstruct();
  }
}

tripwiremodelprecache() {
  precachemodel("_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1");
  precachemodel("_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1");
  precachemodel("_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1");
  precachemodel("_encstr_B8A02159175D5A1C6BAC9BA3AFBBB57D8EE45AC1EE5A4E56D7EEB0368DF516991D95E4");
  precachemodel("_encstr_A59F2456B8D5961CDA2B371DFADD5BEBA393960EDDB43956EBBB2C63B1EBB099E859E4F56062");
  precachemodel("_encstr_839F24A7D395BA5848B18D13EE409D11ED2D1F6B77335305B1DB461D6029D9FA45AB8B5F61C6");
  precachemodel("_encstr_8B9F242F3013A9C3137D4DC3481F2A579BB09783E8480ADA1F0C96FDC9A72236E3A063B76A6B");
  precachemodel("_encstr_9A9F244DCB6BEBB9E9357A54075BCA56253378BBAF4F3A0FA08BF8514131A0F94195B2A9DF09");
  precachemodel("_encstr_AC7A2458B7054089B2076075914BEBCE6CC3B06807A1FB6B79AEEDF3358225319F27B0C0D752");
  precachemodel("_encstr_979B22DD5B10E4037161329B0E544FD1B0C55930BF28EA1F30790A12102E4F165861CDBA");
}

precachetrap(var_0, var_1, var_2) {
  spawntripwirelevelstruct();

  if(!isDefined(level.tripwires.traptypes[var_0])) {
    level.tripwires.traptypes[var_0] = spawnStruct();
    level.tripwires.traptypes[var_0].model = var_1;
    level.tripwires.traptypes[var_0].triggerfunc = gettriggerfunc(var_0);
    level.tripwires.traptypes[var_0].candisarm = var_2;

    if(var_2)
      level.tripwires.traptypes[var_0].disarmfunc = getdisarmfunc(var_0);
  }

  precachemodel(var_1);
}

spawntripwirelevelstruct() {
  if(!isDefined(level.tripwires)) {
    level.tripwires = spawnStruct();
    level.tripwires.traptypes = [];
    level.tripwires.tripwires = [];
    level.tripwires.traps = [];
  }
}

init() {
  if(!isDefined(level.tripwires)) {
    return;
  }
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_88C5055208731B")]]();
  setdvarifuninitialized("_encstr_A54E0F31EA330D8879DC454BE05B3056F7", 0);
  var_0 = scripts\engine\utility::getStructArray("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.target)) {}

    var_3 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_3.size < 1) {}

    foreach(var_5 in var_3)
    buildtripwire(var_2, var_5);
  }
}

buildtripwire(var_0, var_1, var_2) {
  if(!isDefined(var_1.script_animname))
    var_1.script_animname = "_encstr_AFF605A3F9E16B";

  var_3 = spawntripwire(var_0, var_1);
  var_3 inittripwireanims(var_1.script_animname);
  var_3 inittripwirestaticmodel(var_1.script_animname);
  var_3 thread tripwirethink();
  var_3 thread triggertripwirefuncthink(::triggerfunctripwire);

  if(isDefined(var_2))
    var_3.targets = scripts\engine\utility::array_add(var_3.targets, var_2);

  var_3 processtripwiretarget(var_1);
  level.tripwires.tripwires = scripts\engine\utility::array_add(level.tripwires.tripwires, var_3);
  return var_3;
}

processtripwiretarget(var_0) {
  var_1 = "_encstr_B172280FD88BA1CB397802FBD6133264F688F3EFD883E9B363108F7535612A2C71F00F5FF89B51AA5DB7" + var_0.origin + "_encstr_B22287104385E6109BED02E8B09CCE56A3C580045185273B56E840470D9508B237D104E5BDAE01BBC2371D04A3D0AC8047E42DE0DDA593B240E8BD0847E42DB376CAE48502DE9C012C73DED1A1B23901B9C6E496388EAF9BE893576C1DF58E9C96C1EED2392BF55973C8021DED808D7B9B47B47357B240D10DB204E89CD23877B4E4CA406CD0852DB9";

  if(!isDefined(var_0.target)) {
    return;
  }
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  if(var_4.size == 0) {}

  if(var_0 shouldfindnavmodifier())
    self.navmodifier = createnavmodifier(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4) {
    if(var_6 istripwirestruct())
      var_6 = buildtripwire(var_0, var_6, self);
    else if(var_6 istripwiretrapstruct())
      var_6 = buildtripwiretrap(var_6, self);

    self.targets = scripts\engine\utility::array_add(self.targets, var_6);
  }
}

shouldfindnavmodifier() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1)
    return 1;
  else
    return 0;
}

istripwirestruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_8F5A0D6405E753BB534AD9D7151537")
    return 1;
  else
    return 0;
}

istripwiretrapstruct() {
  if(isstruct(self) && isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "_encstr_91D00F5302C30B3B383E150959459A1AB1"))
    return 1;
  else
    return 0;
}

hastripwirechild() {
  foreach(var_1 in self.targets) {
    if(isDefined(var_1.istripwire) && var_1.istripwire && !isDefined(var_1.triggered))
      return 1;
  }

  return 0;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

spawntripwire(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_3.angles = vectortoangles(var_2);
  var_3 setModel(gettripwiremodel(var_1.script_animname));
  var_3 useanimtree(#animtree);

  if(isDefined(var_1.angles)) {
    var_4 = anglesToForward(var_1.angles);
    var_5 = anglestoright(var_3.angles);
    var_6 = anglestoup(var_3.angles);
    var_3.finalangles = axistoangles(var_4, var_5, var_6);
  }

  var_3.targets = [];
  var_3.endpoint = var_0.origin;
  var_3.length = length(var_2);
  var_7 = 30;
  var_8 = var_3.origin + anglesToForward(var_3.angles) * (0.5 * var_3.length);
  var_3.trigger = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_3.origin, 0, var_7, var_3.length + 10);
  var_9 = -1 * anglestoup(var_3.angles);
  var_10 = anglestoright(var_3.angles);
  var_11 = anglesToForward(var_3.angles);
  var_3.trigger.angles = axistoangles(var_9, var_10, var_11);
  var_3.istripwire = 1;
  var_3.triggered = 0;

  if(isDefined(var_0.script_delay))
    var_3.delay = var_0.script_delay;
  else
    var_3.delay = scripts\engine\math::factor_value(0.1, 0.35, var_3 getnormtripwirelength());

  return var_3;
}

inittripwireanims(var_0) {
  if(!isDefined(var_0)) {}

  self.triggeranim = gettripwiretriggeranim(var_0);
  self.stretchanim = gettripwirestretchanim(var_0);
  self setanim(self.triggeranim, 1, 0, 0);
  self setanim(self.stretchanim, 1, 0, 0);

  if(self.length < 10 || self.length > 300) {}

  self setanimtime(self.stretchanim, getnormtripwirelength());
}

inittripwirestaticmodel(var_0) {
  if(!isDefined(var_0)) {}

  self.staticmodel = gettripwirestaticmodel(var_0);
}

gettripwiretriggersound(var_0) {
  if(var_0)
    return "_encstr_965613E84EB41CBBD23995EB1CED1CEBCC4BE4B9E8";
  else if(hastripwirechild())
    return "_encstr_AA590DD91AC0A004C78BB2F1EB809B";
  else
    return "_encstr_84AD12CB88305053FB166FE97F8F5B37F8885F73";
}

tripwirethink() {
  self endon("_encstr_9768116512C76B8734535079CB0A734127ADEE");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_1 = 1;
    var_2 = 1;

    if(tripwireshouldtrigger(var_0))
      self notify("_encstr_8F5C086405E70FBA4B4A", var_0, var_1, var_2);
  }
}

tripwireshouldtrigger(var_0) {
  if(!isDefined(self) || !isDefined(self.origin) || !isDefined(self.endpoint))
    return 0;

  if(!isDefined(var_0) || var_0 isragdoll())
    return 0;

  if(!isalive(var_0))
    return 0;

  var_1 = scripts\engine\trace::create_contents(1, 0, 0, 0, 1, 1, 0, 0, 1);
  var_2 = scripts\engine\trace::ray_trace_ents(self.origin, self.endpoint, var_0, var_1);

  if(!isDefined(var_2["_encstr_A53009A25003666B9818C6"]))
    return 0;

  if(var_2["_encstr_A53009A25003666B9818C6"] < 1)
    return 1;
  else
    return 0;
}

buildtripwiretrap(var_0, var_1) {
  if(!isDefined(var_0.trap)) {
    if(!isDefined(var_0.angles))
      var_2 = (0, 0, 0);
    else
      var_2 = var_0.angles;

    var_0.trap = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_0.trap.angles = var_2;
    var_0.trap setModel(level.tripwires.traptypes[var_0.script_noteworthy].model);
    var_0.trap thread triggertrapfuncthink(level.tripwires.traptypes[var_0.script_noteworthy].triggerfunc);
    var_0.trap thread damagetrapfuncthink();
    var_0.trap.candisarm = level.tripwires.traptypes[var_0.script_noteworthy].candisarm;
    var_0.trap.istrap = 1;

    if(isDefined(level.tripwires.traptypes[var_0.script_noteworthy].disarmfunc))
      var_0.trap thread disarmfuncthink(level.tripwires.traptypes[var_0.script_noteworthy].disarmfunc, var_0);

    if(isDefined(var_0.script_parameters)) {
      var_3 = strtok(var_0.script_parameters, "_encstr_974C0246");
      var_0.trap.grenadeweaponoverride = var_3[0];
    }

    var_0.trap.parenttripwires = [];
    level.tripwires.traps = scripts\engine\utility::array_add(level.tripwires.traps, var_0.trap);
  }

  var_0.trap.parenttripwires = scripts\engine\utility::array_add(var_0.trap.parenttripwires, var_1);
  return var_0.trap;
}

getnormtripwirelength() {
  return scripts\engine\math::normalize_value(10, 300, self.length);
}

tripwirehastraps() {
  foreach(var_1 in self.targets) {
    if(isDefined(var_1.istrap) && !isDefined(var_1.triggered))
      return 1;
  }

  return 0;
}

triggertripwirefuncthink(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1, var_2, var_3);

    if(var_2) {
      break;
    } else if(!tripwirehastraps()) {
      break;
    }
  }

  if(isDefined(var_1))
    var_1.lasttriptime = gettime();

  self notify("_encstr_9768116512C76B8734535079CB0A734127ADEE");
  self.triggered = 1;
  self[[var_0]](var_1, var_2, var_3);
}

triggertrapfuncthink(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1, var_2);

    if(var_2) {
      break;
    }
  }

  self notify("_encstr_ADF70DF3D633F3A77390AF8F208942");
  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  self[[var_0]](var_1);
}

gettriggerfunc(var_0) {
  switch (var_0) {
    case "_encstr_AD7D11A3B259B08CAA8B83EF8B43DFF8D74E23":
      return::triggerfuncc4;
    case "_encstr_9175156D98C32073AB76250FB0BDA960B747876021F8F1":
      return::triggerfuncsemtex;
    case "_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE":
      return::triggerfuncfrag;
    default:
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

gettripwiretriggeranim(var_0) {
  switch (var_0) {
    case "_encstr_BE14081B2B2DD8B47376":
      return scripts\engine\utility::random([%_encstr_A51422AB8E6BBBB7E85847A740A39172DFADB2E9F68962E611B80373017955DAB1333D1F]);
    case "_encstr_9BA90699C67BDBC9":
      return scripts\engine\utility::random([%_encstr_BD3820E86B14B1BBFF12D5C00C4BA0577FE25029D3EBCBD0A3296645CF33483F253B]);
    case "_encstr_AFF605A3F9E16B":
      if(shouldusewallsize1()) {
        return scripts\engine\utility::random([%_encstr_951822C8EA28E0275FDDF0377B1BFC4FE478ABA9A8A4369B9D573369A73FD3BBE1191057]);
        return;
      }

      if(shouldusewallsize2()) {
        return scripts\engine\utility::random([%_encstr_BA1822841B33CA334B0BD7E9D4026A98E8555A3F03893245A0BF0375D743A8A4702182A6]);
        return;
      }

      if(shouldusewallsize3()) {
        return scripts\engine\utility::random([%_encstr_B1182254C5683AF79B7B6AB1C36EC7B74043EAF75F68864B3531130A8EC41FADB04F2003]);
        return;
      }

      if(shouldusewallsize4()) {
        return scripts\engine\utility::random([%_encstr_8C18223370C8989B23CEA7D135FDB257D1609317E003C152016F6A1788AF4A1418491222]);
        return;
      }

      return scripts\engine\utility::random([%_encstr_A1071FCBC33B534BD045CDEF51509447545923E14B0DCFC5504BD2DC6F505E9309]);
      return;
      return;
      return;
      return;
  }
}

gettripwirestaticmodel(var_0) {
  switch (var_0) {
    case "_encstr_BE14081B2B2DD8B47376":
      return "_encstr_AC7A2458B7054089B2076075914BEBCE6CC3B06807A1FB6B79AEEDF3358225319F27B0C0D752";
    case "_encstr_9BA90699C67BDBC9":
      return "_encstr_979B22DD5B10E4037161329B0E544FD1B0C55930BF28EA1F30790A12102E4F165861CDBA";
    case "_encstr_AFF605A3F9E16B":
      if(shouldusewallsize1()) {
        return "_encstr_A59F2456B8D5961CDA2B371DFADD5BEBA393960EDDB43956EBBB2C63B1EBB099E859E4F56062";
        return;
      }

      if(shouldusewallsize2()) {
        return "_encstr_839F24A7D395BA5848B18D13EE409D11ED2D1F6B77335305B1DB461D6029D9FA45AB8B5F61C6";
        return;
      }

      if(shouldusewallsize3()) {
        return "_encstr_8B9F242F3013A9C3137D4DC3481F2A579BB09783E8480ADA1F0C96FDC9A72236E3A063B76A6B";
        return;
      }

      if(shouldusewallsize4()) {
        return "_encstr_9A9F244DCB6BEBB9E9357A54075BCA56253378BBAF4F3A0FA08BF8514131A0F94195B2A9DF09";
        return;
      }

      return "_encstr_B8A02159175D5A1C6BAC9BA3AFBBB57D8EE45AC1EE5A4E56D7EEB0368DF516991D95E4";
      return;
      return;
      return;
      return;
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

gettripwirestretchanim(var_0) {
  switch (var_0) {
    case "_encstr_BE14081B2B2DD8B47376":
      return % _encstr_9AA42247C95A0E772DC92B7D8E27D2D99D56E47DE63A0BE68C2C3919FAE6E8E4B23AC60D;
    case "_encstr_9BA90699C67BDBC9":
      return % _encstr_9AA42247C95A0E772DC92B7D8E27D2D99D56E47DE63A0BE68C2C3919FAE6E8E4B23AC60D;
    case "_encstr_AFF605A3F9E16B":
      return % _encstr_9AA42247C95A0E772DC92B7D8E27D2D99D56E47DE63A0BE68C2C3919FAE6E8E4B23AC60D;
  }
}

gettripwiremodel(var_0) {
  if(!isDefined(var_0)) {}

  switch (var_0) {
    case "_encstr_BE14081B2B2DD8B47376":
      return "_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1";
    case "_encstr_9BA90699C67BDBC9":
      return "_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1";
    case "_encstr_AFF605A3F9E16B":
      return "_encstr_886F22CA2ED5B4386BB2731D7DBBAD7D3AC95A1CBB5AC9B2D7374785E68C16C9C8D736C1";
  }
}

shouldusewallsize1() {
  return self.length >= 51 && self.length < 69;
}

shouldusewallsize2() {
  return self.length >= 69 && self.length < 100;
}

shouldusewallsize3() {
  return self.length > 10 && self.length < 37;
}

shouldusewallsize4() {
  return self.length >= 37 && self.length < 51;
}

#using_animtree("_encstr_B40101");

triggerfunctripwire(var_0, var_1, var_2) {
  self.trigger delete();
  self setanimrate(self.triggeranim, 1);
  self setanim(%_encstr_8CBF19DD7A720133B11BE03977C4EB53CBA65BF0955BE35B6C6F18, 0, 0.2, 1);
  thread swaptostaticmodel();
  self playSound("_encstr_8E6F107DDAD2A1D351FB2BD9DB7F0B47DAC2");
  var_3 = gettripwiretriggersound(var_2);

  if(isDefined(self.finalangles))
    thread rotatetofinalangles();

  wait(self.delay);

  if(isDefined(self.navmodifier))
    destroynavobstacle(self.navmodifier);

  var_2 = 0;

  foreach(var_5 in self.targets)
  var_5 notify("_encstr_8F5C086405E70FBA4B4A", var_0, var_1, var_2);
}

rotatetofinalangles() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.25;
  self rotateTo(self.finalangles, 0.25);
}

swaptostaticmodel() {
  var_0 = getanimlength(self.triggeranim);
  wait(var_0);
  self setModel(self.staticmodel);
}

last_phone_check_fail() {
  var_0 = 1;

  foreach(var_2 in self.parenttripwires) {
    var_2 thread triggerfunctripwire(undefined, 1, var_0);
    var_0 = 0;
  }
}

triggerfuncsemtex(var_0) {
  if(isDefined(self.grenadeweaponoverride))
    var_1 = self.grenadeweaponoverride;
  else
    var_1 = "_encstr_B6F61093887B830F9A20FCF2C363BF0CAD10";

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  var_2 linkTo(self);
  self hide();
  var_2 waittill("_encstr_860808CB78E2984063BA");
  radiusdamage(self.origin, 384, 256, 40, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_92A70ABB8267F5E0D89F6351");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  wait 0.1;
  self notify("_encstr_8A12120BD7A8EF0781A90A1230D93C670D4B9E94");
  self delete();
}

triggerfuncfrag(var_0) {
  if(isDefined(self.grenadeweaponoverride))
    var_1 = self.grenadeweaponoverride;
  else
    var_1 = "_encstr_AABF0E60730E97B6B31ADB4FF72FDB6B";

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  var_2 linkTo(self);
  self hide();
  var_2 waittill("_encstr_860808CB78E2984063BA");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DC1092BD38BC10B7CC337", "_encstr_AF050B70D73D618712AF8D18FE")) {
    var_3 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_AF050B70D73D618712AF8D18FE");
    level thread[[var_3]](self, var_0);
  } else {
    radiusdamage(self.origin, 384, 256, 40, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
    earthquake(0.45, 0.7, self.origin, 800);
  }

  wait 0.1;
  self notify("_encstr_8A12120BD7A8EF0781A90A1230D93C670D4B9E94");
  self delete();
}

triggerfuncc4(var_0) {
  if(isDefined(self.grenadeweaponoverride))
    var_1 = self.grenadeweaponoverride;
  else
    var_1 = "_encstr_A2E70F1AAB80FF2AC1A93A39B9D834B335";

  var_2 = magicgrenademanual(var_1, self.origin, (0, 0, 0), 0.25);
  var_2.angles = self.angles;
  var_2.origin = self.origin;
  var_2 linkTo(self);
  self hide();
  var_2 setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 waittill("_encstr_860808CB78E2984063BA");
  radiusdamage(self.origin, 384, 256, 40, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");
  self playSound("_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  earthquake(0.45, 0.7, self.origin, 800);
  self delete();
}

damagetrapfuncthink(var_0, var_1) {
  self endon("_encstr_ADF70DF3D633F3A77390AF8F208942");
  self setCanDamage(1);
  self.health = 99999;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DC1092BD38BC10B7CC337", "_encstr_B4700D61A8309FE31B8AC07F77AB2B"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_B4700D61A8309FE31B8AC07F77AB2B")]](var_3, var_6);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BD6F0C7A617803CA10813C02BB83")) {
      var_16 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BD6F0C7A617803CA10813C02BB83");

      if(self[[var_16]](var_3, var_11, var_6, var_2, var_5)) {
        break;
      }
    } else if(cantriptrap(var_3, var_6, var_2)) {
      break;
    }

    self.health = self.health + var_2;
  }

  self.triggered = 1;

  if(isDefined(self.defusehintstruct) && !isDefined(self.defusehintstruct.defused)) {
    if(isent(self.defusehintstruct)) {
      self.defusehintstruct makeunusable();
      self.defusehintstruct delete();
    }
  }

  var_17 = 0;
  var_18 = 1;
  self makeunusable();

  foreach(var_20 in self.parenttripwires)
  var_20 notify("_encstr_8F5C086405E70FBA4B4A", var_3, var_17, var_18);

  self notify("_encstr_8F5C086405E70FBA4B4A", var_3, 1);
}

cantriptrap(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == level.player && (var_1 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_1 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B") && var_2 > 150)
    return 1;

  return 0;
}

disarmfuncthink(var_0, var_1) {
  self endon("_encstr_ADF70DF3D633F3A77390AF8F208942");

  if(isDefined(var_1.radius))
    var_2 = var_1.radius;
  else
    var_2 = 128;

  var_3 = (0, 0, 0);
  self.defusehintstruct = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")) {
    var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83");
    self.defusehintstruct = [[var_4]](var_1.origin, undefined, undefined, undefined, undefined, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BECC055CF3811A", 128, 35, 84, 35);
  } else
    self.defusehintstruct = var_1 scripts\engine\utility::spawn_script_origin();

  self.deletefunc = ::last_phone_check_fail;
  self.defusehintstruct waittill("_encstr_8F5C086405E70FBA4B4A", var_5);
  level.lasttripwiredefusedtime = gettime();
  self.defusehintstruct.defused = 1;
  self.triggered = 1;
  var_6 = 0;
  var_7 = 1;

  if(isent(self.defusehintstruct)) {
    self.defusehintstruct makeunusable();
    self.defusehintstruct delete();
  }

  foreach(var_9 in self.parenttripwires)
  var_9 notify("_encstr_8F5C086405E70FBA4B4A", var_5, var_6, var_7);

  self[[var_0]](var_5);
}

getdisarmfunc(var_0) {
  switch (var_0) {
    case "_encstr_9175156D98C32073AB76250FB0BDA960B747876021F8F1":
      return::disarmfuncsemtex;
    case "_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE":
      return::disarmfuncfrag;
    default:
  }
}

disarmfuncsemtex(var_0) {
  var_0 disarmgiveweapon("_encstr_9301076F8808DCFA41", "_encstr_930107EF8808DCFA41");
  self delete();
}

disarmfuncfrag(var_0) {
  var_0 disarmgiveweapon("_encstr_8A78055C8D488C", "_encstr_96ED096AB1DC08239C2C76");
  self delete();
}

disarmgiveweapon(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DC1092BD38BC10B7CC337", "_encstr_9B61118C3B70B63B4115926BB9B4BF6EC08F0E")) {
    var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_9B61118C3B70B63B4115926BB9B4BF6EC08F0E");
    thread[[var_2]](var_0, var_1, self);
  }
}