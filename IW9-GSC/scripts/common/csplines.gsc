/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\csplines.gsc
***********************************************/

cspline_calctangent(p1, p3, _id_6FA3B65720B45808, _id_6FA3B95720B45EA1, _id_70ED5C79B29ED889) {
  _id_9DCCABA98B643CAD = [];
  _id_2BE6F5A8D51BBF4F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = (1 - _id_70ED5C79B29ED889) * (p3[_id_AC0E594AC96AA3A8] - p1[_id_AC0E594AC96AA3A8]);
    _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8];
    _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] * (2 * _id_6FA3B65720B45808 / (_id_6FA3B65720B45808 + _id_6FA3B95720B45EA1));
    _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] * (2 * _id_6FA3B95720B45EA1 / (_id_6FA3B65720B45808 + _id_6FA3B95720B45EA1));
  }

  r = [];
  r["incoming"] = (_id_9DCCABA98B643CAD[0], _id_9DCCABA98B643CAD[1], _id_9DCCABA98B643CAD[2]);
  r["outgoing"] = (_id_2BE6F5A8D51BBF4F[0], _id_2BE6F5A8D51BBF4F[1], _id_2BE6F5A8D51BBF4F[2]);
  return r;
}

cspline_calctangenttcb(p1, p2, p3, _id_6FA3B65720B45808, _id_6FA3B95720B45EA1, t, c, b) {
  _id_9DCCABA98B643CAD = [];
  _id_2BE6F5A8D51BBF4F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = (1 - t) * (1 - c) * (1 + b) * 0.5 * (p2[_id_AC0E594AC96AA3A8] - p1[_id_AC0E594AC96AA3A8]);
    _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] + (1 - t) * (1 + c) * (1 - b) * 0.5 * (p3[_id_AC0E594AC96AA3A8] - p2[_id_AC0E594AC96AA3A8]);
    _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] * (2 * _id_6FA3B65720B45808 / (_id_6FA3B65720B45808 + _id_6FA3B95720B45EA1));
    _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = (1 - t) * (1 + c) * (1 + b) * 0.5 * (p2[_id_AC0E594AC96AA3A8] - p1[_id_AC0E594AC96AA3A8]);
    _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] + (1 - t) * (1 - c) * (1 - b) * 0.5 * (p3[_id_AC0E594AC96AA3A8] - p2[_id_AC0E594AC96AA3A8]);
    _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] * (2 * _id_6FA3B95720B45EA1 / (_id_6FA3B65720B45808 + _id_6FA3B95720B45EA1));
  }

  r = [];
  r["incoming"] = (_id_9DCCABA98B643CAD[0], _id_9DCCABA98B643CAD[1], _id_9DCCABA98B643CAD[2]);
  r["outgoing"] = (_id_2BE6F5A8D51BBF4F[0], _id_2BE6F5A8D51BBF4F[1], _id_2BE6F5A8D51BBF4F[2]);
  return r;
}

cspline_calctangentnatural(p1, p2, _id_CDD57878F51FED58) {
  _id_7DD9C08CCE378F5E = 3;
  _id_9DCCABA98B643CAD = [];
  _id_2BE6F5A8D51BBF4F = [];

  if(isDefined(_id_CDD57878F51FED58)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DD9C08CCE378F5E; _id_AC0E594AC96AA3A8++) {
      _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = (-3 * p1[_id_AC0E594AC96AA3A8] + 3 * p2[_id_AC0E594AC96AA3A8] - _id_CDD57878F51FED58[_id_AC0E594AC96AA3A8]) / 2;
      _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8];
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DD9C08CCE378F5E; _id_AC0E594AC96AA3A8++) {
      _id_9DCCABA98B643CAD[_id_AC0E594AC96AA3A8] = p2[_id_AC0E594AC96AA3A8] - p1[_id_AC0E594AC96AA3A8];
      _id_2BE6F5A8D51BBF4F[_id_AC0E594AC96AA3A8] = p2[_id_AC0E594AC96AA3A8] - p1[_id_AC0E594AC96AA3A8];
    }
  }

  r = [];
  r["incoming"] = (_id_9DCCABA98B643CAD[0], _id_9DCCABA98B643CAD[1], _id_9DCCABA98B643CAD[2]);
  r["outgoing"] = (_id_2BE6F5A8D51BBF4F[0], _id_2BE6F5A8D51BBF4F[1], _id_2BE6F5A8D51BBF4F[2]);
  return r;
}

csplineseg_calccoeffs(p1, p2, _id_CDD57878F51FED58, _id_CDD57B78F51FF3F1) {
  _id_7DD9C08CCE378F5E = 3;
  _id_8FB54A6AD5D31FEC = spawnStruct();
  _id_8FB54A6AD5D31FEC.n3 = [];
  _id_8FB54A6AD5D31FEC.n2 = [];
  _id_8FB54A6AD5D31FEC.n = [];
  _id_8FB54A6AD5D31FEC.c = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DD9C08CCE378F5E; _id_AC0E594AC96AA3A8++) {
    _id_8FB54A6AD5D31FEC.n3[_id_AC0E594AC96AA3A8] = 2 * p1[_id_AC0E594AC96AA3A8] - 2 * p2[_id_AC0E594AC96AA3A8] + _id_CDD57878F51FED58[_id_AC0E594AC96AA3A8] + _id_CDD57B78F51FF3F1[_id_AC0E594AC96AA3A8];
    _id_8FB54A6AD5D31FEC.n2[_id_AC0E594AC96AA3A8] = -3 * p1[_id_AC0E594AC96AA3A8] + 3 * p2[_id_AC0E594AC96AA3A8] - 2 * _id_CDD57878F51FED58[_id_AC0E594AC96AA3A8] - _id_CDD57B78F51FF3F1[_id_AC0E594AC96AA3A8];
    _id_8FB54A6AD5D31FEC.n[_id_AC0E594AC96AA3A8] = _id_CDD57878F51FED58[_id_AC0E594AC96AA3A8];
    _id_8FB54A6AD5D31FEC.c[_id_AC0E594AC96AA3A8] = p1[_id_AC0E594AC96AA3A8];
  }

  return _id_8FB54A6AD5D31FEC;
}

csplineseg_calccoeffscapspeed(p1, p2, _id_CDD57878F51FED58, _id_CDD57B78F51FF3F1, _id_4F281BC957B1BFBE) {
  _id_D1C1D9E4AC08023C = csplineseg_calccoeffs(p1, p2, _id_CDD57878F51FED58, _id_CDD57B78F51FF3F1);
  _id_F2478A60DDDE9FAB = csplineseg_calctopspeed(_id_D1C1D9E4AC08023C, _id_4F281BC957B1BFBE);

  if(_id_F2478A60DDDE9FAB > 1) {
    _id_4F281BC957B1BFBE = _id_4F281BC957B1BFBE * _id_F2478A60DDDE9FAB;
    _id_CDD57878F51FED58 = _id_CDD57878F51FED58 / _id_F2478A60DDDE9FAB;
    _id_CDD57B78F51FF3F1 = _id_CDD57B78F51FF3F1 / _id_F2478A60DDDE9FAB;
    _id_D1C1D9E4AC08023C = csplineseg_calccoeffs(p1, p2, _id_CDD57878F51FED58, _id_CDD57B78F51FF3F1);
  }

  _id_D1C1D9E4AC08023C.endat = _id_4F281BC957B1BFBE;
  return _id_D1C1D9E4AC08023C;
}

cspline_getnodes(_id_16E8B22C9904EAD8) {
  array = [];
  _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[0].endat;
  array[0] = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[0], 0, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[0].speedstart);
  array[0]["time"] = 0;
  _id_694B3083479CD273 = 0;

  for(_id_DE433D5347007B92 = 0; _id_DE433D5347007B92 < _id_16E8B22C9904EAD8.segments.size; _id_DE433D5347007B92++) {
    _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endat - _id_694B3083479CD273;
    array[_id_DE433D5347007B92 + 1] = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92], 1, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedend);
    _id_49C917A0343F8484 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92], 0, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedstart);
    array[_id_DE433D5347007B92]["acc_out"] = _id_49C917A0343F8484["acc"];
    array[_id_DE433D5347007B92 + 1]["time"] = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endtime;
    _id_694B3083479CD273 = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endat;
  }

  array[_id_16E8B22C9904EAD8.segments.size]["acc_out"] = array[_id_16E8B22C9904EAD8.segments.size]["acc"];
  return array;
}

csplineseg_getpoint(_id_A51E141118CAB4EC, x, _id_4F281BC957B1BFBE, _id_1E7771FF7F60E92A) {
  _id_7DD9C08CCE378F5E = 3;
  _id_A93AB3C81F16FC26 = [];
  _id_BB2DB5F98ADEC0B9 = [];
  _id_B6C41F0110CD2E07 = [];
  _id_FB1F805FFA028960 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DD9C08CCE378F5E; _id_AC0E594AC96AA3A8++) {
    _id_A93AB3C81F16FC26[_id_AC0E594AC96AA3A8] = _id_A51E141118CAB4EC.n3[_id_AC0E594AC96AA3A8] * x * x * x + _id_A51E141118CAB4EC.n2[_id_AC0E594AC96AA3A8] * x * x + _id_A51E141118CAB4EC.n[_id_AC0E594AC96AA3A8] * x + _id_A51E141118CAB4EC.c[_id_AC0E594AC96AA3A8];
    _id_BB2DB5F98ADEC0B9[_id_AC0E594AC96AA3A8] = 3 * _id_A51E141118CAB4EC.n3[_id_AC0E594AC96AA3A8] * x * x + 2 * _id_A51E141118CAB4EC.n2[_id_AC0E594AC96AA3A8] * x + _id_A51E141118CAB4EC.n[_id_AC0E594AC96AA3A8];
    _id_B6C41F0110CD2E07[_id_AC0E594AC96AA3A8] = 6 * _id_A51E141118CAB4EC.n3[_id_AC0E594AC96AA3A8] * x + 2 * _id_A51E141118CAB4EC.n2[_id_AC0E594AC96AA3A8];
  }

  _id_FB1F805FFA028960["pos"] = (_id_A93AB3C81F16FC26[0], _id_A93AB3C81F16FC26[1], _id_A93AB3C81F16FC26[2]);
  _id_FB1F805FFA028960["vel"] = (_id_BB2DB5F98ADEC0B9[0], _id_BB2DB5F98ADEC0B9[1], _id_BB2DB5F98ADEC0B9[2]);
  _id_FB1F805FFA028960["acc"] = (_id_B6C41F0110CD2E07[0], _id_B6C41F0110CD2E07[1], _id_B6C41F0110CD2E07[2]);

  if(isDefined(_id_4F281BC957B1BFBE)) {
    _id_FB1F805FFA028960["vel"] = _id_FB1F805FFA028960["vel"] / _id_4F281BC957B1BFBE;
    _id_FB1F805FFA028960["acc"] = _id_FB1F805FFA028960["acc"] / (_id_4F281BC957B1BFBE * _id_4F281BC957B1BFBE);
  }

  if(isDefined(_id_1E7771FF7F60E92A)) {
    _id_FB1F805FFA028960["vel"] = _id_FB1F805FFA028960["vel"] * _id_1E7771FF7F60E92A;
    _id_FB1F805FFA028960["acc"] = _id_FB1F805FFA028960["acc"] * (_id_1E7771FF7F60E92A * _id_1E7771FF7F60E92A);
  }

  _id_FB1F805FFA028960["speed"] = _id_1E7771FF7F60E92A;
  return _id_FB1F805FFA028960;
}

csplineseg_calctopspeed(_id_A51E141118CAB4EC, _id_4F281BC957B1BFBE) {
  _id_CDE77078F534191C = csplineseg_calctopspeedbyderiving(_id_A51E141118CAB4EC, _id_4F281BC957B1BFBE);
  return _id_CDE77078F534191C;
}

csplineseg_calctopspeedbyderiving(_id_A51E141118CAB4EC, _id_4F281BC957B1BFBE) {
  _id_A862027C0896F870 = 0;
  _id_A862037C0896FAA3 = 0;
  _id_9489E95AB4FD15E3 = 0;
  _id_F0309199D49634AE = 0;
  _id_A5B2105AC28996A8 = 0;
  _id_64B1A40441450228 = 0;

  for(axis = 0; axis < 3; axis++) {
    _id_A862027C0896F870 = _id_A862027C0896F870 + _id_A51E141118CAB4EC.n3[axis] * _id_A51E141118CAB4EC.n3[axis];
    _id_A862037C0896FAA3 = _id_A862037C0896FAA3 + _id_A51E141118CAB4EC.n3[axis] * _id_A51E141118CAB4EC.n2[axis];
    _id_9489E95AB4FD15E3 = _id_9489E95AB4FD15E3 + _id_A51E141118CAB4EC.n3[axis] * _id_A51E141118CAB4EC.n[axis];
    _id_F0309199D49634AE = _id_F0309199D49634AE + _id_A51E141118CAB4EC.n2[axis] * _id_A51E141118CAB4EC.n2[axis];
    _id_A5B2105AC28996A8 = _id_A5B2105AC28996A8 + _id_A51E141118CAB4EC.n2[axis] * _id_A51E141118CAB4EC.n[axis];
    _id_64B1A40441450228 = _id_64B1A40441450228 + _id_A51E141118CAB4EC.n[axis] * _id_A51E141118CAB4EC.n[axis];
  }

  a = 36 * _id_A862027C0896F870;
  b = 36 * _id_A862037C0896FAA3;
  c = 12 * _id_9489E95AB4FD15E3 + 8 * _id_F0309199D49634AE;
  _id_AC0E564AC96A9D0F = 4 * _id_A5B2105AC28996A8;
  values = [];
  values[0] = 0;

  if(a == 0) {
    if(b == 0 && c == 0 && _id_AC0E564AC96A9D0F == 0)
      return sqrt(_id_64B1A40441450228) / _id_4F281BC957B1BFBE;

    _id_142D025211AEB4CE = scripts\models\interactive_utility::rootsofquadratic(b, c, _id_AC0E564AC96A9D0F);

    if(isDefined(_id_142D025211AEB4CE[0]) && _id_142D025211AEB4CE[0] > 0 && _id_142D025211AEB4CE[0] < 1) {
      _id_13F52C8DB665C5A4 = 2 * b * _id_142D025211AEB4CE[0] + c;

      if(_id_13F52C8DB665C5A4 < 0)
        values[values.size] = _id_142D025211AEB4CE[0];
    }

    if(isDefined(_id_142D025211AEB4CE[1]) && _id_142D025211AEB4CE[1] > 0 && _id_142D025211AEB4CE[1] < 1) {
      _id_13F52C8DB665C5A4 = 2 * b * _id_142D025211AEB4CE[0] + c;

      if(_id_13F52C8DB665C5A4 < 0)
        values[values.size] = _id_142D025211AEB4CE[1];
    }
  } else {
    _id_93C0F8185D82F877 = scripts\models\interactive_utility::rootsofquadratic(3 * a, 2 * b, c);
    _id_AC0E594AC96AA3A8 = 0;
    points[0] = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_93C0F8185D82F877.size; _id_AC0E594AC96AA3A8++) {
      if(_id_93C0F8185D82F877[_id_AC0E594AC96AA3A8] > 0 && _id_93C0F8185D82F877[_id_AC0E594AC96AA3A8] < 1)
        points[points.size] = _id_93C0F8185D82F877[_id_AC0E594AC96AA3A8];
    }

    points[points.size] = 1;

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < points.size; _id_AC0E594AC96AA3A8++) {
      _id_CDEFFD78F53D3AE1 = points[_id_AC0E594AC96AA3A8 - 1];
      _id_CDEFFC78F53D38AE = points[_id_AC0E594AC96AA3A8];
      _id_5926BC85944973F2 = a * _id_CDEFFD78F53D3AE1 * _id_CDEFFD78F53D3AE1 * _id_CDEFFD78F53D3AE1 + b * _id_CDEFFD78F53D3AE1 * _id_CDEFFD78F53D3AE1 + c * _id_CDEFFD78F53D3AE1 + _id_AC0E564AC96A9D0F;
      _id_4EC590D17B901A2D = a * _id_CDEFFC78F53D38AE * _id_CDEFFC78F53D38AE * _id_CDEFFC78F53D38AE + b * _id_CDEFFC78F53D38AE * _id_CDEFFC78F53D38AE + c * _id_CDEFFC78F53D38AE + _id_AC0E564AC96A9D0F;

      if(_id_5926BC85944973F2 > 0 && _id_4EC590D17B901A2D < 0)
        values[values.size] = scripts\models\interactive_utility::newtonsmethod(_id_CDEFFD78F53D3AE1, _id_CDEFFC78F53D38AE, a, b, c, _id_AC0E564AC96A9D0F, 0.02);
    }
  }

  values[values.size] = 1;
  a = 9 * _id_A862027C0896F870;
  b = 12 * _id_A862037C0896FAA3;
  c = 6 * _id_9489E95AB4FD15E3 + 4 * _id_F0309199D49634AE;
  _id_AC0E564AC96A9D0F = 4 * _id_A5B2105AC28996A8;
  e = _id_64B1A40441450228;
  _id_492C72709D59BCD8 = 0;

  foreach(x in values) {
    _id_8E0F026D9DD0E2B4 = a * x * x * x * x + b * x * x * x + c * x * x + _id_AC0E564AC96A9D0F * x + e;

    if(_id_8E0F026D9DD0E2B4 > _id_492C72709D59BCD8)
      _id_492C72709D59BCD8 = _id_8E0F026D9DD0E2B4;
  }

  return sqrt(_id_492C72709D59BCD8) / _id_4F281BC957B1BFBE;
}

csplineseg_calclengthbystepping(_id_A51E141118CAB4EC, _id_DC3CD00A29A9F03A) {
  _id_8425EFBC1DDF4A48 = csplineseg_getpoint(_id_A51E141118CAB4EC, 0);
  distance = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_DC3CD00A29A9F03A; _id_AC0E594AC96AA3A8++) {
    n = _id_AC0E594AC96AA3A8 / _id_DC3CD00A29A9F03A;
    _id_6C53D859D582A421 = csplineseg_getpoint(_id_A51E141118CAB4EC, n);
    distance = distance + length(_id_8425EFBC1DDF4A48["pos"] - _id_6C53D859D582A421["pos"]);
    _id_8425EFBC1DDF4A48 = _id_6C53D859D582A421;
  }

  return distance;
}

csplineseg_calctopspeedbystepping(_id_A51E141118CAB4EC, _id_DC3CD00A29A9F03A, _id_4F281BC957B1BFBE) {
  _id_8425EFBC1DDF4A48 = csplineseg_getpoint(_id_A51E141118CAB4EC, 0);
  _id_F2478A60DDDE9FAB = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_DC3CD00A29A9F03A; _id_AC0E594AC96AA3A8++) {
    n = _id_AC0E594AC96AA3A8 / _id_DC3CD00A29A9F03A;
    _id_6C53D859D582A421 = csplineseg_getpoint(_id_A51E141118CAB4EC, n);
    distance = length(_id_8425EFBC1DDF4A48["pos"] - _id_6C53D859D582A421["pos"]);

    if(distance > _id_F2478A60DDDE9FAB)
      _id_F2478A60DDDE9FAB = distance;

    _id_8425EFBC1DDF4A48 = _id_6C53D859D582A421;
  }

  _id_F2478A60DDDE9FAB = _id_F2478A60DDDE9FAB * (_id_DC3CD00A29A9F03A / _id_4F281BC957B1BFBE);
  return _id_F2478A60DDDE9FAB;
}

cspline_findpathnodes(_id_E68B39E2CB8B811A) {
  next_node = _id_E68B39E2CB8B811A;
  array = [];

  for(_id_D47972BAB60448BA = 0; isDefined(next_node.target); _id_D47972BAB60448BA++) {
    array[_id_D47972BAB60448BA] = next_node;
    targetname = next_node.target;
    next_node = getnode(targetname, "targetname");

    if(!isDefined(next_node)) {
      next_node = getvehiclenode(targetname, "targetname");

      if(!isDefined(next_node)) {
        next_node = getEnt(targetname, "targetname");

        if(!isDefined(next_node))
          next_node = scripts\engine\utility::getStruct(targetname, "targetname");
      }
    }
  }

  array[_id_D47972BAB60448BA] = next_node;
  return array;
}

cspline_makepath1seg(_id_D917428537562C1F, _id_BA4976D286544764, _id_5914DC8594357CF6, _id_4ED790D17BA45789) {
  nodes = [];
  nodes[0] = spawnStruct();
  nodes[0].origin = _id_D917428537562C1F;

  if(isDefined(_id_5914DC8594357CF6)) {
    nodes[0].speed = length(_id_5914DC8594357CF6);
    _id_5914DC8594357CF6 = _id_5914DC8594357CF6 / nodes[0].speed;
    nodes[0].speed = nodes[0].speed * 20;
  } else
    nodes[0].speed = 20;

  nodes[1] = spawnStruct();
  nodes[1].origin = _id_BA4976D286544764;

  if(isDefined(_id_4ED790D17BA45789)) {
    nodes[1].speed = length(_id_4ED790D17BA45789);
    _id_4ED790D17BA45789 = _id_4ED790D17BA45789 / nodes[1].speed;
    nodes[1].speed = nodes[1].speed * 20;
  } else
    nodes[1].speed = 20;

  return cspline_makepath(nodes, 1, _id_5914DC8594357CF6, _id_4ED790D17BA45789);
}

cspline_makepathtopoint(_id_D917428537562C1F, _id_BA4976D286544764, _id_5914DC8594357CF6, _id_4ED790D17BA45789, _id_6486C8CC78D0B52E) {
  _id_451B85725D725AC9 = [];

  if(!isDefined(_id_6486C8CC78D0B52E))
    _id_6486C8CC78D0B52E = 0;

  if(isDefined(_id_5914DC8594357CF6)) {
    _id_BD0E09E2AE58263E = length(_id_5914DC8594357CF6);
    _id_451B85725D725AC9[0] = _id_5914DC8594357CF6 / _id_BD0E09E2AE58263E;
    _id_BD0E09E2AE58263E = _id_BD0E09E2AE58263E * 20;
  } else
    _id_BD0E09E2AE58263E = 20;

  if(isDefined(_id_4ED790D17BA45789)) {
    _id_743E1CA3CEE36B69 = length(_id_4ED790D17BA45789);
    _id_451B85725D725AC9[1] = _id_4ED790D17BA45789 / _id_743E1CA3CEE36B69;
    _id_743E1CA3CEE36B69 = _id_743E1CA3CEE36B69 * 20;
  } else
    _id_743E1CA3CEE36B69 = 20;

  if(_id_BD0E09E2AE58263E / _id_743E1CA3CEE36B69 > 1.2 || _id_743E1CA3CEE36B69 / _id_BD0E09E2AE58263E > 1.2 || _id_6486C8CC78D0B52E) {
    if(!isDefined(_id_451B85725D725AC9[0]))
      _id_451B85725D725AC9[0] = (0, 0, 0);

    if(!isDefined(_id_451B85725D725AC9[1]))
      _id_451B85725D725AC9[1] = (0, 0, 0);
  }

  _id_471FD2E43673DF40 = _id_BA4976D286544764 - _id_D917428537562C1F;
  _id_5C7DC4E92DE4142E = length(_id_471FD2E43673DF40);
  pathdir = _id_471FD2E43673DF40 / _id_5C7DC4E92DE4142E;
  nodes = [];
  nodes[0] = spawnStruct();
  nodes[0].origin = _id_D917428537562C1F;
  nodes[0].speed = _id_BD0E09E2AE58263E;
  _id_B0C87A8953462B5B = [];
  _id_1B69369ED5CB9124 = max(_id_BD0E09E2AE58263E, _id_743E1CA3CEE36B69);

  if(isDefined(_id_451B85725D725AC9[0]))
    _id_B0C87A8953462B5B[0] = (_id_BD0E09E2AE58263E + _id_1B69369ED5CB9124) / 40;

  if(isDefined(_id_451B85725D725AC9[1]))
    _id_B0C87A8953462B5B[1] = (_id_743E1CA3CEE36B69 + _id_1B69369ED5CB9124) / 40;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_451B85725D725AC9[_id_AC0E594AC96AA3A8])) {
      sign = (0.5 - _id_AC0E594AC96AA3A8) * 2;
      _id_F36436FA7801BB1C = _id_451B85725D725AC9[_id_AC0E594AC96AA3A8];
      _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * sign;
      _id_1B4F8AE8E1E1EA06 = vectordot(_id_F36436FA7801BB1C, pathdir);

      if(_id_1B4F8AE8E1E1EA06 * sign < 0.3 || _id_BD0E09E2AE58263E / _id_743E1CA3CEE36B69 > 1.2 || _id_743E1CA3CEE36B69 / _id_BD0E09E2AE58263E > 1.2 || _id_6486C8CC78D0B52E) {
        if(_id_1B4F8AE8E1E1EA06 * sign < 0) {
          _id_3152BBF664B154CC = _id_1B4F8AE8E1E1EA06 * pathdir;
          _id_F36436FA7801BB1C = _id_F36436FA7801BB1C - _id_3152BBF664B154CC;
          _id_F36436FA7801BB1C = vectorNormalize(_id_F36436FA7801BB1C);
          _id_F36436FA7801BB1C = _id_F36436FA7801BB1C + _id_3152BBF664B154CC;
        }

        _id_F36436FA7801BB1C = _id_F36436FA7801BB1C + pathdir * sign;
        _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * _id_B0C87A8953462B5B[_id_AC0E594AC96AA3A8];
        _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * (sqrt(_id_5C7DC4E92DE4142E) * 2);
        nodes[nodes.size] = spawnStruct();

        if(_id_AC0E594AC96AA3A8 == 0)
          nodes[nodes.size - 1].origin = _id_D917428537562C1F + _id_F36436FA7801BB1C;
        else
          nodes[nodes.size - 1].origin = _id_BA4976D286544764 + _id_F36436FA7801BB1C;

        nodes[nodes.size - 1].speed = _id_1B69369ED5CB9124;
      }
    }
  }

  n = nodes.size;
  nodes[n] = spawnStruct();
  nodes[n].origin = _id_BA4976D286544764;
  nodes[n].speed = _id_743E1CA3CEE36B69;
  return cspline_makepath(nodes, 1, _id_451B85725D725AC9[0], _id_451B85725D725AC9[1]);
}

cspline_makepath(nodes, _id_3B969D8C66F20F14, _id_5914DC8594357CF6, _id_4ED790D17BA45789, _id_E46DA62B29DE231A) {
  _id_16E8B22C9904EAD8 = spawnStruct();
  _id_16E8B22C9904EAD8.segments = [];

  if(!isDefined(_id_3B969D8C66F20F14))
    _id_3B969D8C66F20F14 = 0;

  if(!isDefined(_id_E46DA62B29DE231A))
    _id_E46DA62B29DE231A = 1;

  _id_0B7D05E702B39C1F = 0;
  _id_2EF92E549DAC50CD = [];

  for(_id_233D5873C30516DD = distance(nodes[0].origin, nodes[1].origin); isDefined(nodes[_id_16E8B22C9904EAD8.segments.size + 2]); _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat = _id_0B7D05E702B39C1F) {
    _id_AC0E594AC96AA3A8 = _id_16E8B22C9904EAD8.segments.size;
    _id_AE4BBF6283072CF2 = nodes[_id_AC0E594AC96AA3A8].origin;
    nextpoint = nodes[_id_AC0E594AC96AA3A8 + 1].origin;
    _id_7FB743940D0907E1 = nodes[_id_AC0E594AC96AA3A8 + 2].origin;
    _id_1AA7C21C6D587AD2 = _id_233D5873C30516DD;
    _id_233D5873C30516DD = distance(nodes[_id_AC0E594AC96AA3A8 + 1].origin, nodes[_id_AC0E594AC96AA3A8 + 2].origin);
    _id_B8FA75BBC94CC24D = _id_2EF92E549DAC50CD;
    _id_2EF92E549DAC50CD = cspline_calctangent(_id_AE4BBF6283072CF2, _id_7FB743940D0907E1, _id_1AA7C21C6D587AD2, _id_233D5873C30516DD, 0.5);

    if(_id_AC0E594AC96AA3A8 == 0) {
      if(isDefined(_id_5914DC8594357CF6))
        _id_B8FA75BBC94CC24D["outgoing"] = _id_5914DC8594357CF6 * _id_1AA7C21C6D587AD2;
      else
        _id_B8FA75BBC94CC24D = cspline_calctangentnatural(_id_AE4BBF6283072CF2, nextpoint, _id_2EF92E549DAC50CD["incoming"]);
    }

    if(_id_E46DA62B29DE231A) {
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8] = csplineseg_calccoeffscapspeed(_id_AE4BBF6283072CF2, nextpoint, _id_B8FA75BBC94CC24D["outgoing"], _id_2EF92E549DAC50CD["incoming"], _id_1AA7C21C6D587AD2);
      _id_0B7D05E702B39C1F = _id_0B7D05E702B39C1F + _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat;
      continue;
    }

    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8] = csplineseg_calccoeffs(_id_AE4BBF6283072CF2, nextpoint, _id_B8FA75BBC94CC24D["outgoing"], _id_2EF92E549DAC50CD["incoming"]);
    _id_0B7D05E702B39C1F = _id_0B7D05E702B39C1F + _id_1AA7C21C6D587AD2;
  }

  _id_AC0E594AC96AA3A8 = _id_16E8B22C9904EAD8.segments.size;
  _id_AE4BBF6283072CF2 = nodes[_id_AC0E594AC96AA3A8].origin;
  nextpoint = nodes[_id_AC0E594AC96AA3A8 + 1].origin;
  _id_1AA7C21C6D587AD2 = _id_233D5873C30516DD;
  _id_B8FA75BBC94CC24D = _id_2EF92E549DAC50CD;

  if(_id_AC0E594AC96AA3A8 == 0 && isDefined(_id_5914DC8594357CF6))
    _id_B8FA75BBC94CC24D["outgoing"] = _id_5914DC8594357CF6 * _id_1AA7C21C6D587AD2;

  if(isDefined(_id_4ED790D17BA45789))
    _id_2EF92E549DAC50CD["incoming"] = _id_4ED790D17BA45789 * _id_1AA7C21C6D587AD2;
  else
    _id_2EF92E549DAC50CD = cspline_calctangentnatural(_id_AE4BBF6283072CF2, nextpoint, _id_B8FA75BBC94CC24D["outgoing"]);

  if(_id_AC0E594AC96AA3A8 == 0 && !isDefined(_id_5914DC8594357CF6))
    _id_B8FA75BBC94CC24D = cspline_calctangentnatural(_id_AE4BBF6283072CF2, nextpoint, _id_2EF92E549DAC50CD["incoming"]);

  if(_id_E46DA62B29DE231A) {
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8] = csplineseg_calccoeffscapspeed(_id_AE4BBF6283072CF2, nextpoint, _id_B8FA75BBC94CC24D["outgoing"], _id_2EF92E549DAC50CD["incoming"], _id_1AA7C21C6D587AD2);
    _id_0B7D05E702B39C1F = _id_0B7D05E702B39C1F + _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat;
  } else {
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8] = csplineseg_calccoeffs(_id_AE4BBF6283072CF2, nextpoint, _id_B8FA75BBC94CC24D["outgoing"], _id_2EF92E549DAC50CD["incoming"]);
    _id_0B7D05E702B39C1F = _id_0B7D05E702B39C1F + _id_1AA7C21C6D587AD2;
  }

  _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat = _id_0B7D05E702B39C1F;

  if(_id_3B969D8C66F20F14) {
    _id_5B16491505732B2B = 0;
    _id_89CF4CFA83F8226C = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16E8B22C9904EAD8.segments.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(nodes[_id_AC0E594AC96AA3A8 + 1].speed))
        nodes[_id_AC0E594AC96AA3A8 + 1].speed = nodes[_id_AC0E594AC96AA3A8].speed;

      _id_1AA7C21C6D587AD2 = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat - _id_89CF4CFA83F8226C;
      _id_D45A089BF298CB7B = 2 * _id_1AA7C21C6D587AD2 / ((nodes[_id_AC0E594AC96AA3A8].speed + nodes[_id_AC0E594AC96AA3A8 + 1].speed) / 20);
      _id_5B16491505732B2B = _id_5B16491505732B2B + _id_D45A089BF298CB7B;
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime = _id_5B16491505732B2B;
      _id_89CF4CFA83F8226C = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat;
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart = nodes[_id_AC0E594AC96AA3A8].speed / 20;
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedend = nodes[_id_AC0E594AC96AA3A8 + 1].speed / 20;
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16E8B22C9904EAD8.segments.size; _id_AC0E594AC96AA3A8++) {
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endat;
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart = 1;
      _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedend = 1;
    }
  }

  return _id_16E8B22C9904EAD8;
}

cspline_movefirstpoint(_id_16E8B22C9904EAD8, _id_8B11B8A7273B4007, _id_3513C7A6E895BB1A) {
  _id_A0EEC69077D8135E = spawnStruct();
  _id_A0EEC69077D8135E.segments = [];
  _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[0], 1);
  _id_7452AB549FCC55E9 = _id_C93C413792DB2F38["pos"] - _id_8B11B8A7273B4007;
  _id_4F281BC957B1BFBE = length(_id_7452AB549FCC55E9);
  _id_A0EEC69077D8135E.segments[0] = csplineseg_calccoeffs(_id_8B11B8A7273B4007, _id_C93C413792DB2F38["pos"], _id_3513C7A6E895BB1A * _id_4F281BC957B1BFBE, _id_C93C413792DB2F38["vel"]);
  _id_A0EEC69077D8135E.segments[0].endtime = _id_16E8B22C9904EAD8.segments[0].endtime * _id_4F281BC957B1BFBE / _id_16E8B22C9904EAD8.segments[0].endat;
  _id_A0EEC69077D8135E.segments[0].endat = _id_4F281BC957B1BFBE;
  _id_556F368DE6756BD6 = _id_4F281BC957B1BFBE - _id_16E8B22C9904EAD8.segments[0].endat;
  _id_FBD43DA47D8CECDF = _id_A0EEC69077D8135E.segments[0].endtime - _id_16E8B22C9904EAD8.segments[0].endtime;

  for(_id_BE2008030AD6EA7A = 1; _id_BE2008030AD6EA7A < _id_16E8B22C9904EAD8.segments.size; _id_BE2008030AD6EA7A++) {
    _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A] = csplineseg_copy(_id_16E8B22C9904EAD8.segments[_id_BE2008030AD6EA7A]);
    _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A].endat = _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A].endat + _id_556F368DE6756BD6;
    _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A].endtime = _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A].endtime + _id_FBD43DA47D8CECDF;
  }

  return _id_A0EEC69077D8135E;
}

cspline_getpointatdistance(_id_16E8B22C9904EAD8, distance, _id_E86A48D7721D1142) {
  if(distance <= 0) {
    _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[0].endat;
    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[0], 0, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[0].speedstart);
    return _id_C93C413792DB2F38;
  } else if(distance >= _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat) {
    if(_id_16E8B22C9904EAD8.segments.size > 1)
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat - _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 2].endat;
    else
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat;

    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1], 1, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].speedend);
    return _id_C93C413792DB2F38;
  } else {
    for(_id_DE433D5347007B92 = 0; _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endat < distance; _id_DE433D5347007B92++) {}

    if(_id_DE433D5347007B92 > 0)
      _id_B64A0A3741630F36 = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92 - 1].endat;
    else
      _id_B64A0A3741630F36 = 0;

    _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endat - _id_B64A0A3741630F36;
    _id_840ACC643EEB4984 = (distance - _id_B64A0A3741630F36) / _id_4F281BC957B1BFBE;
    speed = undefined;

    if(isDefined(_id_E86A48D7721D1142) && _id_E86A48D7721D1142)
      speed = cspline_speedfromdistance(_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedstart, _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedend, _id_840ACC643EEB4984);

    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92], _id_840ACC643EEB4984, _id_4F281BC957B1BFBE, speed);
    return _id_C93C413792DB2F38;
  }
}

cspline_getpointattime(_id_16E8B22C9904EAD8, time) {
  if(time <= 0) {
    _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[0].endat;
    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[0], 0, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[0].speedstart);
    return _id_C93C413792DB2F38;
  } else if(time >= _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endtime) {
    if(_id_16E8B22C9904EAD8.segments.size > 1)
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat - _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 2].endat;
    else
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat;

    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1], 1, _id_4F281BC957B1BFBE, _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].speedend);
    return _id_C93C413792DB2F38;
  } else {
    for(_id_DE433D5347007B92 = 0; _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endtime < time; _id_DE433D5347007B92++) {}

    if(_id_DE433D5347007B92 > 0) {
      starttime = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92 - 1].endtime;
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endat - _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92 - 1].endat;
    } else {
      starttime = 0;
      _id_4F281BC957B1BFBE = _id_16E8B22C9904EAD8.segments[0].endat;
    }

    _id_D45A089BF298CB7B = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].endtime - starttime;
    _id_47AF4311A1D5AFDA = (time - starttime) / _id_D45A089BF298CB7B;
    speed = _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedstart + _id_47AF4311A1D5AFDA * (_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedend - _id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedstart);
    dist = (time - starttime) * (_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92].speedstart + speed) / 2;
    _id_2BB3FE9E063AB673 = dist / _id_4F281BC957B1BFBE;
    _id_C93C413792DB2F38 = csplineseg_getpoint(_id_16E8B22C9904EAD8.segments[_id_DE433D5347007B92], _id_2BB3FE9E063AB673, _id_4F281BC957B1BFBE, speed);
    return _id_C93C413792DB2F38;
  }
}

cspline_speedfromdistance(speedstart, speedend, _id_C17BE29704EA710F) {
  _id_AC0E564AC96A9D0F = _id_C17BE29704EA710F;
  a = (speedend - speedstart) * (speedend + speedstart) / 2;
  return sqrt(2 * a * _id_AC0E564AC96A9D0F + speedstart * speedstart);
}

cspline_adjusttime(_id_16E8B22C9904EAD8, _id_4046BF37E49E7A5C) {
  _id_C55D260E33520B13 = cspline_time(_id_16E8B22C9904EAD8);
  _id_CDDE8578F52A289D = _id_16E8B22C9904EAD8.segments[0].endtime;
  _id_CDDE8478F52A266A = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 2].endtime - _id_CDDE8578F52A289D;
  _id_CDDE8378F52A2437 = _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endtime - _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 2].endtime;
  _id_24BAB19D89A4F95E = 2 * _id_CDDE8578F52A289D + _id_CDDE8478F52A266A + 2 * _id_CDDE8378F52A2437 - _id_4046BF37E49E7A5C;
  r = (sqrt(_id_24BAB19D89A4F95E * _id_24BAB19D89A4F95E + 4 * _id_CDDE8478F52A266A * _id_4046BF37E49E7A5C) + _id_24BAB19D89A4F95E) / (2 * _id_4046BF37E49E7A5C);
  nexttime = undefined;
  _id_3DB761983738BAD9 = undefined;
  _id_16E8B22C9904EAD8.segments[0].speedend = _id_16E8B22C9904EAD8.segments[0].speedend * r;
  offset = _id_16E8B22C9904EAD8.segments[0].endtime * (1 / r - 2 / (1 + r));
  _id_16E8B22C9904EAD8.segments[0].endtime = _id_16E8B22C9904EAD8.segments[0].endtime / ((1 + r) / 2);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_16E8B22C9904EAD8.segments.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_4B3282DF24F1C4CF = undefined;
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart * r;
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedend = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedend * r;
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime / r;
    _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime - offset;
  }

  _id_AC0E594AC96AA3A8 = _id_16E8B22C9904EAD8.segments.size - 1;
  _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart = _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].speedstart * r;
  _id_16E8B22C9904EAD8.segments[_id_AC0E594AC96AA3A8].endtime = _id_4046BF37E49E7A5C;
}

cspline_makenoisepath(_id_A61C75B156FC1EE0, _id_BA033AECCA09825A, _id_B8A569BEF8F3AC2C, _id_2769945FADE1149C) {
  nodes = cspline_makenoisepathnodes(_id_A61C75B156FC1EE0, _id_BA033AECCA09825A, _id_B8A569BEF8F3AC2C);

  if(isDefined(_id_2769945FADE1149C))
    nodes[1].origin = _id_2769945FADE1149C;

  _id_0C84F6220E6636C5 = spawnStruct();
  _id_0C84F6220E6636C5.origin = nodes[0].origin;
  nodes[nodes.size] = _id_0C84F6220E6636C5;
  _id_0C84F6220E6636C5 = spawnStruct();
  _id_0C84F6220E6636C5.origin = nodes[1].origin;
  nodes[nodes.size] = _id_0C84F6220E6636C5;
  _id_0C84F6220E6636C5 = spawnStruct();
  _id_0C84F6220E6636C5.origin = nodes[2].origin;
  nodes[nodes.size] = _id_0C84F6220E6636C5;
  _id_16E8B22C9904EAD8 = cspline_makepath(nodes);
  _id_A0EEC69077D8135E = spawnStruct();
  _id_A0EEC69077D8135E.segments = [];

  for(_id_BE2008030AD6EA7A = 0; _id_BE2008030AD6EA7A < _id_16E8B22C9904EAD8.segments.size - 2; _id_BE2008030AD6EA7A++) {
    _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A] = csplineseg_copy(_id_16E8B22C9904EAD8.segments[_id_BE2008030AD6EA7A + 1]);
    _id_A0EEC69077D8135E.segments[_id_BE2008030AD6EA7A].endat = _id_BE2008030AD6EA7A + 1;
  }

  return _id_A0EEC69077D8135E;
}

cspline_makenoisepathnodes(_id_A61C75B156FC1EE0, _id_BA033AECCA09825A, _id_B8A569BEF8F3AC2C) {
  nodes = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++) {
    nodes[_id_AC0E594AC96AA3A8] = spawnStruct();
    x = randomfloatrange(_id_BA033AECCA09825A[0], _id_B8A569BEF8F3AC2C[0]);
    y = randomfloatrange(_id_BA033AECCA09825A[1], _id_B8A569BEF8F3AC2C[1]);
    z = randomfloatrange(_id_BA033AECCA09825A[2], _id_B8A569BEF8F3AC2C[2]);
    nodes[_id_AC0E594AC96AA3A8].origin = (x, y, z);
  }

  return nodes;
}

cspline_test(_id_16E8B22C9904EAD8, _id_DA3A760322EB2A6A) {}

cspline_testnodes(nodes, _id_DA3A760322EB2A6A) {
  _id_A61C75B156FC1EE0 = 20;
  prevnode = undefined;

  foreach(node in nodes) {
    if(isDefined(prevnode))
      thread scripts\engine\utility::draw_arrow_time(prevnode.origin, node.origin, (0, 1, 0), _id_DA3A760322EB2A6A);

    prevnode = node;
  }

  foreach(node in nodes) {
    thread scripts\engine\utility::draw_line_for_time(node.origin - (_id_A61C75B156FC1EE0, 0, 0), node.origin + (_id_A61C75B156FC1EE0, 0, 0), 1, 1, 0, _id_DA3A760322EB2A6A);
    thread scripts\engine\utility::draw_line_for_time(node.origin - (0, _id_A61C75B156FC1EE0, 0), node.origin + (0, _id_A61C75B156FC1EE0, 0), 1, 1, 0, _id_DA3A760322EB2A6A);
    thread scripts\engine\utility::draw_line_for_time(node.origin - (0, 0, _id_A61C75B156FC1EE0), node.origin + (0, 0, _id_A61C75B156FC1EE0), 1, 1, 0, _id_DA3A760322EB2A6A);
  }
}

csplineseg_copy(_id_D1C1D9E4AC08023C) {
  _id_7D1B1559E2A469CE = spawnStruct();
  _id_7DD9C08CCE378F5E = 3;

  for(_id_AC0E564AC96A9D0F = 0; _id_AC0E564AC96A9D0F < _id_7DD9C08CCE378F5E; _id_AC0E564AC96A9D0F++) {
    _id_7D1B1559E2A469CE.n3[_id_AC0E564AC96A9D0F] = _id_D1C1D9E4AC08023C.n3[_id_AC0E564AC96A9D0F];
    _id_7D1B1559E2A469CE.n2[_id_AC0E564AC96A9D0F] = _id_D1C1D9E4AC08023C.n2[_id_AC0E564AC96A9D0F];
    _id_7D1B1559E2A469CE.n[_id_AC0E564AC96A9D0F] = _id_D1C1D9E4AC08023C.n[_id_AC0E564AC96A9D0F];
    _id_7D1B1559E2A469CE.c[_id_AC0E564AC96A9D0F] = _id_D1C1D9E4AC08023C.c[_id_AC0E564AC96A9D0F];
  }

  _id_7D1B1559E2A469CE.endat = _id_D1C1D9E4AC08023C.endat;
  _id_7D1B1559E2A469CE.endtime = _id_D1C1D9E4AC08023C.endtime;
  return _id_7D1B1559E2A469CE;
}

cspline_length(_id_16E8B22C9904EAD8) {
  return _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endat;
}

cspline_time(_id_16E8B22C9904EAD8) {
  return _id_16E8B22C9904EAD8.segments[_id_16E8B22C9904EAD8.segments.size - 1].endtime;
}

cspline_initnoise(center, _id_BEE8C8BB2FAD4C3B, _id_45205AE104161076, startpoint) {
  _id_CE514278F5A8BE1A = spawnStruct();
  _id_1C4935F823206E4A = _id_BEE8C8BB2FAD4C3B;
  _id_CE514278F5A8BE1A.largestep = _id_45205AE104161076;
  _id_D1CE8B6B88E44A5C = (center[0] - _id_1C4935F823206E4A, center[1] - _id_1C4935F823206E4A, center[2] - _id_1C4935F823206E4A);
  _id_D1AB796B88BDDB0E = (center[0] + _id_1C4935F823206E4A, center[1] + _id_1C4935F823206E4A, center[2] + _id_1C4935F823206E4A);

  if(!isDefined(startpoint))
    startpoint = (center[0], center[1], center[2] - _id_1C4935F823206E4A);

  _id_CE514278F5A8BE1A.largescale = cspline_makenoisepath(10, _id_D1CE8B6B88E44A5C, _id_D1AB796B88BDDB0E, startpoint);
  _id_CE514278F5A8BE1A.largescale.length = _id_CE514278F5A8BE1A.largescale.segments[_id_CE514278F5A8BE1A.largescale.segments.size - 1].endat;
  thread cspline_test(_id_CE514278F5A8BE1A.largescale, 20);
  return _id_CE514278F5A8BE1A;
}

cspline_noise(_id_CE514278F5A8BE1A, _id_E0333ADDD3893F6A) {
  _id_CDDE4978F529A4A9 = scripts\engine\utility::mod(_id_E0333ADDD3893F6A / _id_CE514278F5A8BE1A.largestep, _id_CE514278F5A8BE1A.largescale.length);
  _id_CDCD4978F5179A4D = cspline_getpointatdistance(_id_CE514278F5A8BE1A.largescale, _id_CDDE4978F529A4A9);
  return _id_CDCD4978F5179A4D["pos"];
}