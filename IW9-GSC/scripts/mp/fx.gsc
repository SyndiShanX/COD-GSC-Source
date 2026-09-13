/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\fx.gsc
***********************************************/

script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target))
    org = getEnt(self.target).origin;
  else
    org = "undefined";

  if(self.script_fxcommand == "OneShotfx") {}

  if(self.script_fxcommand == "loopfx") {}

  if(self.script_fxcommand == "loopsound")
    return;
}

grenadeexplosionfx(pos) {
  playFX(level._effect["mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}

soundfx(_id_8C44BF99399EDF9A, _id_CC5C9FF8C3C69BB7, _id_374D7614ECBD032A) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = _id_CC5C9FF8C3C69BB7;
  org playLoopSound(_id_8C44BF99399EDF9A);

  if(isDefined(_id_374D7614ECBD032A))
    org thread soundfxdelete(_id_374D7614ECBD032A);
}

soundfxdelete(_id_374D7614ECBD032A) {
  level waittill(_id_374D7614ECBD032A);
  self delete();
}

func_glass_handler() {
  _id_F5207DC7648BAED9 = [];
  _id_5F91AC0FAE720AAC = [];
  _id_20D527E317C41D46 = getEntArray("vfx_custom_glass", "targetname");

  foreach(_id_D533D2E71A306C3A in _id_20D527E317C41D46) {
    if(isDefined(_id_D533D2E71A306C3A.script_noteworthy)) {
      _id_8D25F853511AC66E = getglass(_id_D533D2E71A306C3A.script_noteworthy);

      if(isDefined(_id_8D25F853511AC66E)) {
        _id_5F91AC0FAE720AAC[_id_8D25F853511AC66E] = _id_D533D2E71A306C3A;
        _id_F5207DC7648BAED9[_id_F5207DC7648BAED9.size] = _id_8D25F853511AC66E;
      }
    }
  }

  _id_5765C257F01F4F2B = _id_F5207DC7648BAED9.size;
  _id_5356EA5B8D524EC1 = _id_F5207DC7648BAED9.size;
  _id_380081ED3D43C6AA = 5;
  _id_BBB45D49F4EAF799 = 0;

  while(_id_5765C257F01F4F2B != 0) {
    _id_44D2425A54839042 = _id_BBB45D49F4EAF799 + _id_380081ED3D43C6AA - 1;

    if(_id_44D2425A54839042 > _id_5356EA5B8D524EC1)
      _id_44D2425A54839042 = _id_5356EA5B8D524EC1;

    if(_id_BBB45D49F4EAF799 == _id_5356EA5B8D524EC1)
      _id_BBB45D49F4EAF799 = 0;

    while(_id_BBB45D49F4EAF799 < _id_44D2425A54839042) {
      _id_D3F442EBD2D75D2C = _id_F5207DC7648BAED9[_id_BBB45D49F4EAF799];
      _id_D533D2E71A306C3A = _id_5F91AC0FAE720AAC[_id_D3F442EBD2D75D2C];

      if(isDefined(_id_D533D2E71A306C3A)) {
        if(isglassdestroyed(_id_D3F442EBD2D75D2C)) {
          _id_D533D2E71A306C3A delete();
          _id_5765C257F01F4F2B--;
          _id_5F91AC0FAE720AAC[_id_D3F442EBD2D75D2C] = undefined;
        }
      }

      _id_BBB45D49F4EAF799++;
    }

    wait 0.05;
  }
}

blenddelete(_id_245DC63EC7CE506C) {
  self waittill("death");
  _id_245DC63EC7CE506C delete();
}