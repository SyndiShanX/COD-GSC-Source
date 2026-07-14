/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2072313b2844b9b5.gsc
*****************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace pbgpostfx;

function autoexec preinit() {
  if(function_9c44e6874f16932e(1)) {
    return;
  }

  level callback::add(#"register_fullscreenfx", &function_ec6fef0b4389cc1b);

  if(!isDefined(level.fullscreenfx)) {
    level.fullscreenfx = spawnStruct();
  }
}

function function_ec6fef0b4389cc1b(params) {
  fullscreenfxtechnique = level.gamemodebundle.fullscreenfxtechnique ?? #"visionset";

  if(level.gamemodebundle.fullscreenfxtechnique != #"pbgpostfxbundle") {
    return;
  }

  utility::registersharedfunc(#"fullscreenfx", #"setpain", &setpain);
  utility::registersharedfunc(#"fullscreenfx", #"setdeath", &setdeath);
  utility::registersharedfunc(#"fullscreenfx", #"hash_f7bfc77c8b6be6e5", &function_d83fe9a0e16b868);
  utility::registersharedfunc(#"fullscreenfx", #"hash_702fe2dff06ac055", &function_a6072b9012c3e950);
  utility::registersharedfunc(#"fullscreenfx", #"hash_967b2afe3d37405", &function_270ab7977ed0dcd0);
  utility::registersharedfunc(#"fullscreenfx", #"senddamageevent", &senddamageevent);
  utility::registersharedfunc(#"fullscreenfx", #"hash_d6d2b1e7868b8f30", &function_e5ca24b8ebd3094d);
  utility::registersharedfunc(#"fullscreenfx", #"hash_fd9af8d6ec7cc6fb", &function_af953127cb592712);
  utility::registersharedfunc(#"fullscreenfx", #"hash_382df7654f0561bd", &function_f9065fc15ab7af84);
  utility::registersharedfunc(#"fullscreenfx", #"hash_494b07757cd511a5", &function_5777084295492040);
  level.var_5d5a8dba0f6b0275 = level.gamemodebundle.fullscreenfxtechnique;
}

function setpain(params) {
  if(isDefined(params.postfxbundlename)) {
    pbgpostfxbundlesetpain(params.postfxbundlename);
  }
}

function setdeath(params) {
  if(isDefined(params.postfxbundlename)) {
    pbgpostfxbundlesetdeath(params.postfxbundlename);
  }
}

function function_d83fe9a0e16b868(params) {
  if(isDefined(params.postfxbundlename)) {
    function_c929d6021012a699(params.postfxbundlename);
    level.fullscreenfx.var_5be0bb0f8a57c4b2 = params.postfxbundlename;
  }
}

function function_a6072b9012c3e950(params) {
  if(isDefined(params.postfxbundlename)) {
    function_12c8ab194cfb244f(params.postfxbundlename);
    level.fullscreenfx.var_7ec215883ecaffd2 = params.postfxbundlename;
  }
}

function function_270ab7977ed0dcd0() {
  setpain({
    #postfxbundlename: level.gamemodebundle.pbgpostfxbundle_pain
  });
  setdeath({
    #postfxbundlename: level.gamemodebundle.pbgpostfxbundle_death
  });
  function_d83fe9a0e16b868({
    #postfxbundlename: level.gamemodebundle.var_5be0bb0f8a57c4b2
  });
  function_a6072b9012c3e950({
    #postfxbundlename: level.gamemodebundle.var_7ec215883ecaffd2
  });
}

function senddamageevent(damageevent) {
  pbgpostfxbundlestart(damageevent.player, level.fullscreenfx.var_5be0bb0f8a57c4b2);
  pbgpostfxbundlestart(damageevent.player, level.fullscreenfx.var_7ec215883ecaffd2);
}

function function_e5ca24b8ebd3094d(params) {
  if(isDefined(params.postfxbundlename)) {
    pbgpostfxbundlestart(self, params.postfxbundlename, params.timelinescale, params.mix);
    self.var_29672ac7f027ccee = params.postfxbundlename;
  }
}

function function_af953127cb592712(params) {
  pbgpostfxbundlename = params.postfxbundlename ?? self.var_29672ac7f027ccee;

  if(isDefined(pbgpostfxbundlename)) {
    pbgpostfxbundleend(self, pbgpostfxbundlename, params.timelinescale);
    self.var_29672ac7f027ccee = undefined;
  }
}

function function_f9065fc15ab7af84(params, var_5ca08adbc1839b02, candelaystart) {
  endstring = getxhashhexname(params.postfxbundlename) + "\xae\xc7\x04\x98";
  thread function_33be07dfaed0be27(params, var_5ca08adbc1839b02, candelaystart, endstring);
}

function function_5777084295492040(params) {
  self notify(getxhashhexname(params.postfxbundlename) + "\xae\xc7\x04\x98", params);
}

function private function_33be07dfaed0be27(params, var_5ca08adbc1839b02, candelaystart, endstring) {
  self endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon(endstring);

  while(true) {
    if(istrue(var_5ca08adbc1839b02) && utility::isusingremote()) {
      if(istrue(candelaystart)) {
        self waittill("&\xa16\x19\x90\xce\xba\xbf\x8a\xddG\xfekCD\xebb\x8b\x98\xa9");
      } else {
        return;
      }
    }

    pbgpostfxbundlestart(self, params.postfxbundlename, params.timelinescale, params.mix);
    thread function_7df89a77e1df6410(endstring);
    thread function_c6a5950abf6ab46f(params, endstring);
    self waittill("C0J\xc0\\8D\xd8\xf8I\x8e\xfc");
    pbgpostfxbundlekill(self, params.postfxbundlename);
  }
}

function private function_7df89a77e1df6410(endstring) {
  self endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("C0J\xc0\\8D\xd8\xf8I\x8e\xfc");
  self waittill(endstring, params);
  pbgpostfxbundleend(self, params.postfxbundlename, params.timelinescale);
}

function private function_c6a5950abf6ab46f(params, endstring) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("C0J\xc0\\8D\xd8\xf8I\x8e\xfc");
  self endon(endstring);
  level waittill(",\x91N\xc1\x1cy\x1bCRgs\xe4\xbd\xafl\xe0\x9e\xf0\x12\x9f");
  pbgpostfxbundlekill(self, params.postfxbundlename);
}