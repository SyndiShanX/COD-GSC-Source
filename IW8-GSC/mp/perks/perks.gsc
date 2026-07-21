/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\perks.gsc
***********************************************/

init() {
  level thread scripts\mp\perks\perkfunctions::rechargeequipmentthink_init();
  level thread scripts\mp\perks\perkfunctions::supersprintkillrefresh_init();
  level thread scripts\mp\perks\perkfunctions::sixthsense_think();
  level.perkfuncs = [];
  level.menuperks = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.extraperkmap = [];
  level.menurigperks = [];
  registerscriptperk("_encstr_BEF4111A80D95E49B0A1D040E6103721326D73", scripts\mp\perks\perkfunctions::sethealer, scripts\mp\perks\perkfunctions::unsethealer, ["_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD", "_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702"]);
  registerscriptperk("_encstr_A6B5137F3019DB2A03F1D388700FA372C350F387D8", scripts\mp\perks\perkfunctions::setsurvivor, scripts\mp\perks\perkfunctions::unsetsurvivor, ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"]);
  registerscriptperk("_encstr_960412DC1CB26C96B0C68E5EFA6EAE3807B79C3A", scripts\mp\perks\perkfunctions::setsupport, scripts\mp\perks\perkfunctions::unsetsupport, ["_encstr_AF911B1780B7F053671A5BE231079C908CE9A5A1075AA0A8D36251698B"]);
  registerscriptperk("_encstr_BA9516DC07CA1B2DB08D1D97AF23B2B6DE63A5A3D2EDDC9B", scripts\mp\perks\perkfunctions::setdemolitions, scripts\mp\perks\perkfunctions::unsetdemolitions, ["_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953"]);
  registerscriptperk("_encstr_B453120ADBF8B35A77196B571726D3ED70E04354", scripts\mp\perks\perkfunctions::setstealth, scripts\mp\perks\perkfunctions::unsetstealth, ["_encstr_990810B8796F28FB0B6193B21770B42573B3", "_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF"]);
  registerscriptperk("_encstr_82EB149367A51F026879C5F83F716BB011D3E36A8280", scripts\mp\perks\perkfunctions::setmunitions, scripts\mp\perks\perkfunctions::unsetmunitions, ["_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728"]);
  registerscriptperk("_encstr_845212B79302E610017DE35AA9FB1028EB6B033D", scripts\mp\perks\perkfunctions::setspotter, scripts\mp\perks\perkfunctions::unsetspotter, ["_encstr_81FE1A3F1B8A6EA889F57BD2D171389EC1F79385DF71ADA0B20F418B", "_encstr_9B63139B09C036574770439BFEAD93EF088D051565", "_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD"]);
  registerscriptperk("_encstr_ADC50F138148BECFDFF83B1366AD2735E0", scripts\mp\perks\perkfunctions::settank, scripts\mp\perks\perkfunctions::unsettank);
  registerscriptperk("_encstr_A38D13A343A04392178DFBD0271ADDADFF5E548753", scripts\mp\perks\perkfunctions::setbreacher, scripts\mp\perks\perkfunctions::unsetbreacher);
  registerscriptperk("_encstr_8A0110D3EB5567B4F8217471AF50BDE38DC0", scripts\mp\perks\perkfunctions::setintel, scripts\mp\perks\perkfunctions::unsetintel);
  registerscriptperk("_encstr_87DF113707958D5AC21B8E5EBEA1EA733A5693", scripts\mp\perks\perkfunctions::sethunter, scripts\mp\perks\perkfunctions::unsethunter);
  registerscriptperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75", scripts\mp\perks\perkfunctions::setreviveuseweapon, scripts\mp\perks\perkfunctions::unsetreviveuseweapon, ["_encstr_84C710D3602B067FF9F9BCB918AD378F5B60"]);
  registerscriptperk("_encstr_85AB1DC0F30F97D46AAB3B6351BFCDFB6C8ADBBF5F5F5BCC65063FACA00311", undefined, undefined, ["_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"]);
  registerscriptperk("_encstr_81791663D09B96EF69094C498891AFDD1D11FAEB906B4E23", scripts\mp\perks\perkfunctions::setdoorbreach, scripts\mp\perks\perkfunctions::unsetdoorbreach);
  registerscriptperk("_encstr_B6B31E079087C063570A4B92412FAED89D1181AB172F08374B12E2D96A5BD5D8");
  registerscriptperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E", scripts\mp\perks\perkfunctions::setruggedeqp, scripts\mp\perks\perkfunctions::unsetruggedeqp, ["_encstr_B4D722B907ACB1B4C28DA3CBFA950FD193C2BE831B2CCDD1B291EBCA5CEAA5076B569B1D"]);
  registerscriptperk("_encstr_B4D722B907ACB1B4C28DA3CBFA950FD193C2BE831B2CCDD1B291EBCA5CEAA5076B569B1D");
  registerscriptperk("_encstr_A26A1B38A3FF6F8037D4857B8F5FA923E59AB8E0C917BB7B1BD2B7F88D");
  registerscriptperk("_encstr_92C61ECD0EB21BA5B063D12FAFC226B4C6B43A5EFA23CA58326ED2D8AC9B3656");
  registerscriptperk("_encstr_AD631DD38762326AC178543BD79B2E4CF1981B980F08A05720B0BBD0F6B8BA");
  registerscriptperk("_encstr_B15419AF8B1AFE183945EB42A1E19823621729239FB33E60405C72");
  registerscriptperk("_encstr_96C51DC3703B364FC9E9ACA968913BFC41C03BFBA1AD6FAFE0C084BA1858EF");
  registerscriptperk("_encstr_9A5E1C6253A378EA825020FB60C16BDA39EB0943D66091D6622BD6CB7203");
  registerscriptperk("_encstr_91D41B60EB079AD70903C5F009FBD50B2C93636AB8AA95C5B0719098B8");
  registerscriptperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19", scripts\mp\perks\perkfunctions::setblastshield, scripts\mp\perks\perkfunctions::unsetblastshield);
  registerscriptperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565", scripts\mp\perks\perkfunctions::setengineer, scripts\mp\perks\perkfunctions::unsetengineer, ["_encstr_B1011D12C3E0AB520F61634F1F20DBF41048CD1F58687C3A5E3973374BDA63"]);
  registerscriptperk("_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8", undefined, undefined, ["_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947", "_encstr_B10D24371CACC64BB036A32F7D13C97D98B2D1D12B4ED7B6D2379B5AED9BBE395977164E4637"]);
  registerscriptperk("_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765", undefined, undefined, ["_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728"]);
  registerscriptperk("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2", undefined, undefined, ["_encstr_990810B8796F28FB0B6193B21770B42573B3", "_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C"]);
  registerscriptperk("_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733", undefined, undefined, ["_encstr_87FB22DCE0B26CD20BB1A3BCFAA56B0727F667CA32AF334B95B1C8AF5D1CCE930B4695CD", "_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085", "_encstr_922F1B3FA88FC87B4F02339A592BAE71E71187B925B2E13E67BBE863C2"]);
  registerscriptperk("_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F", undefined, undefined, ["_encstr_B8251D93206B463FB9B9FCF9D823F78E99300B6A2047BF171313E015ED88FB"]);
  registerscriptperk("_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B", undefined, undefined, ["_encstr_AC191F77E0D7903307BAFB429197F5C06F5AFFE98ABCA085D7C2B0685A8BA6D0C7", "_encstr_81A71D7BE920D6B7A79063BBDE0CCF8AC0B7F2FF4BA8DC6F58CB4AE2E15053"]);
  registerscriptperk("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735", undefined, undefined, ["_encstr_9B63139B09C036574770439BFEAD93EF088D051565", "_encstr_85A318D237DB22713140FBD7C1E8317BBFC5DACB13591A8538A8", "_encstr_B86B0F0F88EB3F6A91A01141914B12E24B"]);
  registerscriptperk("_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8", undefined, undefined, ["_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA", "_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93", "_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D", "_encstr_8BA31B339B413F3148C5C45A3F677FADBFF3425B7D5DAFF3CDA31A1F63", "_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B"]);
  registerscriptperk("_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871", undefined, undefined, ["_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC", "_encstr_A525253BC72DCE64888D531381EE1B39A7581BF2D0612790AD2867E108076FA8B6096323CDA015"]);
  registerscriptperk("_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", undefined, undefined, ["_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3"]);
  registerscriptperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F", scripts\mp\perks\perkfunctions::sethardline, scripts\mp\perks\perkfunctions::unsethardline, ["_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330"]);
  registerscriptperk("_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6", undefined, undefined, ["_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953", "_encstr_8D33136E83B28D96C28D3ABCAF6E43C92C1CB9568D"]);
  registerscriptperk("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F", undefined, undefined, ["_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7", "_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9", "_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532", "_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D", "_encstr_818B1DB9C1AC8D962C1B47CBAF37D20FE834EBDC2BB99BCAAF96B6B5D573B2"]);
  registerscriptperk("_encstr_9A360EC74F39AA043E1D2333C71D30C3", undefined, undefined, ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19", "_encstr_9B2A145B1F89AF44DB704B930119FC132004D2C13E10", "_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A"]);
  registerscriptperk("_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB", undefined, undefined, ["_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B", "_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD", "_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D"]);
  registerscriptperk("_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", undefined, undefined, ["_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F", "_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9"]);
  registerscriptperk("_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C", undefined, undefined, ["_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1", "_encstr_AADA2ABF034A2A8996F583BA26E0C7714BBF7D11A84D49231AD65D63F9C65FB7A7603E7818D2FB76D4E04570", "_encstr_A946261781314E6450C08D0376EB4D9773282796FBBBEFB750BF71BA04C7930905620EA151E9F58A"]);
  registerscriptperk("_encstr_9A8A14CDC1CA365AB08DD1CBAFDAB29C1BCAE6C24E97", undefined, undefined, ["_encstr_B1B5116ECA8217E0A9731878D7C278639A73E3"]);
  registerscriptperk("_encstr_95591036E007F94BC6620878491A0F106F8A", undefined, undefined, ["_encstr_AAB419B907596CB4C2D81D2FAF168DDD58E59BBED62DB92DADC207"]);
  registerscriptperk("_encstr_852B16FB50A76BDA31784DE7914F12994395D0B07565858B", undefined, undefined, ["_encstr_9B7318FFD19D1A4128900B50EE6093C36729C7775337730F385B"]);
  registerscriptperk("_encstr_A6F51B234BDFF6086654D9DB7FCA884D7F72F948226FB581FE3FE5CB7B", scripts\mp\perks\perkfunctions::_id_131C2, scripts\mp\perks\perkfunctions::_id_13F6E);
  registerscriptperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947", scripts\mp\perks\perkfunctions::setkillstreaktoscorestreak, scripts\mp\perks\perkfunctions::unsetkillstreaktoscorestreak);
  registerscriptperk("_encstr_87FB22DCE0B26CD20BB1A3BCFAA56B0727F667CA32AF334B95B1C8AF5D1CCE930B4695CD");
  registerscriptperk("_encstr_B8251D93206B463FB9B9FCF9D823F78E99300B6A2047BF171313E015ED88FB", scripts\mp\perks\perkfunctions::setrechargeequipment, scripts\mp\perks\perkfunctions::unsetrechargeequipment);
  registerscriptperk("_encstr_960624285042C66A89B22B335F0BCBDBE5E6494E939B283D38A9B20BB5882993A23B9309FA71");
  registerscriptperk("_encstr_85A318D237DB22713140FBD7C1E8317BBFC5DACB13591A8538A8", scripts\mp\perks\perkfunctions::setmarkequipment, scripts\mp\perks\perkfunctions::unsetmarkequipment);
  registerscriptperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC", scripts\mp\perks\perkfunctions::_id_13137, scripts\mp\perks\perkfunctions::_id_13F64);
  registerscriptperk("_encstr_9B7318FFD19D1A4128900B50EE6093C36729C7775337730F385B", scripts\mp\perks\perkfunctions::setscrapweapons, scripts\mp\perks\perkfunctions::unsetscrapweapons);
  registerscriptperk("_encstr_A9D515BF13499B4B5E3D7BD3C6EA6067925F432151F5D3", scripts\mp\perks\perkfunctions::setdooralarm, scripts\mp\perks\perkfunctions::unsetdooralarm);
  registerscriptperk("_encstr_AAB419B907596CB4C2D81D2FAF168DDD58E59BBED62DB92DADC207", scripts\mp\perks\perkfunctions::setalwaysminimap, scripts\mp\perks\perkfunctions::unsetalwaysminimap);
  registerscriptperk("_encstr_8D33136E83B28D96C28D3ABCAF6E43C92C1CB9568D");
  registerscriptperk("_encstr_9352191ED83FC163EE7A60CB21C323D9B74FA69E218BC9A557F228");
  registerscriptperk("_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9", scripts\mp\perks\perkfunctions::setfastreloadlaunchers, scripts\mp\perks\perkfunctions::unsetfastreloadlaunchers);
  registerscriptperk("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93");
  registerscriptperk("_encstr_818B1DB9C1AC8D962C1B47CBAF37D20FE834EBDC2BB99BCAAF96B6B5D573B2");
  registerscriptperk("_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A");
  registerscriptperk("_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1", scripts\mp\perks\perkfunctions::_id_131B8, scripts\mp\perks\perkfunctions::_id_13F6C);
  registerscriptperk("_encstr_A946261781314E6450C08D0376EB4D9773282796FBBBEFB750BF71BA04C7930905620EA151E9F58A", scripts\mp\perks\perkfunctions::_id_131BA, undefined);
  registerscriptperk("_encstr_AADA2ABF034A2A8996F583BA26E0C7714BBF7D11A84D49231AD65D63F9C65FB7A7603E7818D2FB76D4E04570", scripts\mp\perks\perkfunctions::setreduceregendelayonobjective, scripts\mp\perks\perkfunctions::unsetreduceregendelayonobjective);
  registerscriptperk("_encstr_8BA31B339B413F3148C5C45A3F677FADBFF3425B7D5DAFF3CDA31A1F63");
  registerscriptperk("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");
  registerscriptperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
  registerscriptperk("_encstr_922F1B3FA88FC87B4F02339A592BAE71E71187B925B2E13E67BBE863C2");
  registerscriptperk("_encstr_B10D24371CACC64BB036A32F7D13C97D98B2D1D12B4ED7B6D2379B5AED9BBE395977164E4637", scripts\mp\perks\perkfunctions::_id_1312C, scripts\mp\perks\perkfunctions::_id_13F63);
  registerscriptperk("_encstr_A525253BC72DCE64888D531381EE1B39A7581BF2D0612790AD2867E108076FA8B6096323CDA015");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    registerscriptperk("_encstr_96671CB3C285F853FA4311F3773226D1481C9889A1E7E8AF825F2BCBBF6A", scripts\mp\perks\perkfunctions::_id_13199, scripts\mp\perks\perkfunctions::_id_13F69);
    registerscriptperk("_encstr_B68A1CDC072BC696C2C63AE5F54CC9FA37A339B7B93BCA937DC2C9ADDE27", scripts\mp\perks\perkfunctions::_id_131C5, scripts\mp\perks\perkfunctions::_id_13F6F);
  } else {
    registerscriptperk("_encstr_96671CB3C285F853FA4311F3773226D1481C9889A1E7E8AF825F2BCBBF6A");
    registerscriptperk("_encstr_B68A1CDC072BC696C2C63AE5F54CC9FA37A339B7B93BCA937DC2C9ADDE27");
  }

  registerscriptperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD", scripts\mp\perks\perkfunctions::setregenfaster, scripts\mp\perks\perkfunctions::unsetregenfaster);
  registerscriptperk("_encstr_84C710D3602B067FF9F9BCB918AD378F5B60");
  registerscriptperk("_encstr_8B6C1EA0CF3577AB41CA809B97E2CB17A92D9EFAE3B8297B4E183049B8974702", scripts\mp\perks\perkfunctions::setreduceregendelay, scripts\mp\perks\perkfunctions::unsetreduceregendelay);
  registerscriptperk("_encstr_BD0E1962B390DB221F71737F2F366A1E99191FE16B38767AEC0B3B");
  registerscriptperk("_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD");
  registerscriptperk("_encstr_81FE1A3F1B8A6EA889F57BD2D171389EC1F79385DF71ADA0B20F418B", scripts\mp\perks\perkfunctions::setadsmarktarget, scripts\mp\perks\perkfunctions::unsetadsmarktarget);
  registerscriptperk("_encstr_8F0A1450CB9717F85F8CDD53A78743C3FD13F078536B", scripts\mp\perks\perkfunctions::setarmorvest, scripts\mp\perks\perkfunctions::unsetarmorvest);
  registerscriptperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B", scripts\mp\perks\perkfunctions::settracker, scripts\mp\perks\perkfunctions::unsettracker, ["_encstr_A9B916B9C1568D9658D8D1CBBE8EE4B036D6AC4EFA1C9CF6"]);
  registerscriptperk("_encstr_990810B8796F28FB0B6193B21770B42573B3", scripts\mp\perks\perkfunctions::setghost, scripts\mp\perks\perkfunctions::unsetghost, ["_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693"]);
  registerscriptperk("_encstr_971E11AB60DF3FAAB9E903C09909897DA8CDE0", scripts\mp\perks\perkfunctions::sethelmet, scripts\mp\perks\perkfunctions::unsethelmet);
  registerscriptperk("_encstr_99D211D3BADDC894A1ECFBC1C90AF77B805036", scripts\mp\perks\perkfunctions::setladder, scripts\mp\perks\perkfunctions::unsetladder);
  registerscriptperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953", scripts\mp\perks\perkfunctions::setextradeadly, scripts\mp\perks\perkfunctions::unsetextradeadly);
  registerscriptperk("_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF", scripts\mp\perks\perkfunctions::setremotedefuse, scripts\mp\perks\perkfunctions::unsetremotedefuse);
  registerscriptperk("_encstr_B86B0F0F88EB3F6A91A01141914B12E24B");
  registerscriptperk("_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085");
  registerscriptperk("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6");
  registerscriptperk("_encstr_B2D9157B3B83979FA3E9BB803F12D0D850B11840DE4275", scripts\mp\perks\perkfunctions::setdoorsense, scripts\mp\perks\perkfunctions::unsetdoorsense);
  registerscriptperk("_encstr_B8331AF8E881BAC72F65FC0BA7AB528640955D8769F23DE51A3422C8", scripts\mp\perks\perkfunctions::setworsenedgunkick, scripts\mp\perks\perkfunctions::unsetworsenedgunkick);
  registerscriptperk("_encstr_BE321990CB6D69D3EAEDD55B09C21310DFDFB0C8BF0101E1B29544");
  registerscriptperk("_encstr_8CED153FA88FC87B4F02339A593F2DF8621585871F3098");
  registerscriptperk("_encstr_A2821B5F1039FB0A6391B3E810112283C158AFA758D63D729D3AFC2564", scripts\mp\perks\perkfunctions::setlocationmarking, scripts\mp\perks\perkfunctions::unsetlocationmarking);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    registerscriptperk("_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95", undefined, undefined, ["_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756", "_encstr_92D3177FE8CF883B0F42F35A99AFEDC86742F1DB617290F02F"]);
  else
    registerscriptperk("_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95", undefined, undefined, ["_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756"]);

  registerscriptperk("_encstr_AABE17C8530F9F70E70455CBDF03DB1FB42AF098FAE5DB6BEB", undefined, undefined, ["_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756", "_encstr_92D3177FE8CF883B0F42F35A99AFEDC86742F1DB617290F02F"]);
  registerscriptperk("_encstr_927F15BBFF694FE47BD0EB3361551A0703673F3415B1C3", undefined, undefined, ["_encstr_9B63139B09C036574770439BFEAD93EF088D051565"]);
  registerscriptperk("_encstr_AB5D15A3CB5F7688E6D4595BFF0E18D0A343792982B736", undefined, undefined, ["_encstr_A9B916B9C1568D9658D8D1CBBE8EE4B036D6AC4EFA1C9CF6"]);
  registerscriptperk("_encstr_BEAB159B783767182121DB7F1FB17A0F8B48F788732822", undefined, undefined, ["_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392"]);
  registerscriptperk("_encstr_8203161F7318A7DFC1D2254BF6E6063F75F323B3978A39EB", undefined, undefined, ["_encstr_8AA21393E26518B31AA3F1D357E28FD833BAD8A90D"]);
  registerscriptperk("_encstr_A6451BE6E0596C2D0BB13AE5BE1327D7B9C62BA59D431DED99D058E68C", undefined, undefined, ["_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7"]);
  registerscriptperk("_encstr_B241146EE0B236A5B08D8EBCD72627F51AAC58D8B29C", undefined, undefined);
  registerscriptperk("_encstr_8D111B8B3FE5600941A3A37027198397E9B17F3D4026670443DAD7654A", undefined, undefined);
  registerscriptperk("_encstr_813E1CBF280F48FBCF82B31AD9AB2EF1A6823B0FB2728037AB0A88C14233", undefined, undefined);
  registerscriptperk("_encstr_ACA41AFB1B6BF9937ADB5C3B08BD6510F5FFD3A28BCB34DB9B9B7F06", scripts\mp\perks\perkfunctions::setbountyhunter, scripts\mp\perks\perkfunctions::unsetbountyhunter);
  registerscriptperk("_encstr_81801C0BB8F3EE9701115461A04933393BF88222B877A6EF9B8D46774593", undefined, undefined);
  registerscriptperk("_encstr_A5BF1E12877FE3CC02C4DCDA6F75C601A34347F8328768B7D6AB255036CF491B", undefined, undefined);
  registerscriptperk("_encstr_865013A373482BFBE0426B73E90D08FF50EC608B1D", undefined, undefined, ["_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693"]);
  registerscriptperk("_encstr_AC74148B3BF569F021A0B312380E0AA66738C5CFBF69", undefined, undefined, ["_encstr_87DF113707958D5AC21B8E5EBEA1EA733A5693"]);
  registerscriptperk("_encstr_8AEA113783CA36A50B36E8BCEB9893BEB2BD46", undefined, undefined, ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19", "_encstr_B86B0F0F88EB3F6A91A01141914B12E24B", "_encstr_9B2A145B1F89AF44DB704B930119FC132004D2C13E10", "_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A"]);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    registerscriptperk("_encstr_91111BD740773093A7DA9B22F173D6198EAC556BF65E586D8702F0ABAB", undefined, undefined, ["_encstr_96671CB3C285F853FA4311F3773226D1481C9889A1E7E8AF825F2BCBBF6A"]);
    registerscriptperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32", undefined, undefined, ["_encstr_B68A1CDC072BC696C2C63AE5F54CC9FA37A339B7B93BCA937DC2C9ADDE27"]);
  } else {
    registerscriptperk("_encstr_91111BD740773093A7DA9B22F173D6198EAC556BF65E586D8702F0ABAB", undefined, undefined, undefined);
    registerscriptperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32", undefined, undefined, undefined);
  }

  registerscriptperk("_encstr_823218E6832B1B96C2B1A3E5BE989CFACDB2270ECAB9A3A5B956", undefined, undefined, ["_encstr_9B5C1A16B2FA6F88C12B3040FF1A23DF635A0E938D432310AFCFB810"]);
  registerscriptperk("_encstr_9B5C1A16B2FA6F88C12B3040FF1A23DF635A0E938D432310AFCFB810", undefined, undefined);
  registerscriptperk("_encstr_B2F310EB9AED903B822B495BCFAB7D988334", scripts\mp\perks\perkfunctions::_id_131B3, scripts\mp\perks\perkfunctions::_id_13F6A);
  registerscriptperk("_encstr_ADCA1183F295E843EAB3E1E36742161026C84A", undefined, undefined, ["_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1"]);
  registerscriptperk("_encstr_BAC313BAA24009C4126563BBD982C46340150DC7E7", undefined, undefined);
  registerscriptperk("_encstr_8D171520BBE707E84FBCED63B73753DBCE92A858A27AB3", scripts\mp\perks\perkfunctions::_id_131B4, scripts\mp\perks\perkfunctions::_id_13F6B);
  registerscriptperk("_encstr_AC90148F7337B0A060A94BA09F7BC86AE303E1781717", scripts\mp\perks\perkfunctions::_id_13159, scripts\mp\perks\perkfunctions::_id_13F65);
  registerscriptperk("_encstr_A5EB18FB8AFD802BB21B594BBF2A657086A763F0B733F0D52A23", scripts\mp\perks\perkfunctions::_id_13176, scripts\mp\perks\perkfunctions::_id_13F66);
  registerscriptperk("_encstr_BEFE102FB89FD80B3F72238A695337083403", scripts\mp\perks\perkfunctions::_id_13195, scripts\mp\perks\perkfunctions::_id_13F68);
  registerscriptperk("_encstr_B16618F7D342A650413DA31AE93B486699AB5B570BFB7C709112", scripts\mp\perks\perkfunctions::_id_131D0, scripts\mp\perks\perkfunctions::_id_13F70);
  registerscriptperk("_encstr_9B81109BE0AC36D20B8DE82F7DCE4B3A85B1");
  registerscriptperk("_encstr_A271139AA86DC14B6FC03BE37F238AC35B03DA7E48", undefined, undefined, ["_encstr_A5EB18FB8AFD802BB21B594BBF2A657086A763F0B733F0D52A23", "_encstr_B28F1DB983AC8DA5B0D88EF2EB99B06E47275963BDC246FAD2B9D4BA27B28C"]);
  registerscriptperk("_encstr_85ED160B9950A627378DD30B4E1F23DBF8059275F5506F83", scripts\mp\perks\perkfunctions::setafterburner, scripts\mp\perks\perkfunctions::unsetafterburner, ["_encstr_97D713A7F33FFEA116B04BD0DFD34C5A954F393755"]);
  registerscriptperk("_encstr_A745130E4B52CF08EBD17431070B60BCE7DB523FD1", scripts\mp\perks\perkfunctions::setautospot, scripts\mp\perks\perkfunctions::unsetautospot);
  registerscriptperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072", scripts\mp\perks\perkfunctions::setboom, scripts\mp\perks\perkfunctions::unsetboom);
  registerscriptperk("_encstr_9AE514B0EB4D49F30A0D35BB29B22350B127D8E82BE5", scripts\mp\perks\perkfunctions::setdelaymine, scripts\mp\perks\perkfunctions::unsetdelaymine);
  registerscriptperk("_encstr_A3C314370E953696858D3A5EBE19590F8EB24E5AA397", undefined, undefined, ["_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7", "_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F"]);
  registerscriptperk("_encstr_A3E21427B0E7A003376A2BB2612BCFE07F2F9BDD4D0F", undefined, undefined, ["_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598", "_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9", "_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA"]);
  registerscriptperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA", scripts\mp\perks\perkfunctions::setempimmune, scripts\mp\perks\perkfunctions::unsetempimmune);
  registerscriptperk("_encstr_97D21AA7F33FFEA116B04BD0DF9748DA8C3F37345D59DD39B0531F07");
  registerscriptperk("_encstr_AA2514F33B2B51BB019C1071EE99BBD122276893EBA2", scripts\mp\perks\perkfunctions::setextraammo, scripts\mp\perks\perkfunctions::unsetextraammo);
  registerscriptperk("_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959", scripts\mp\perks\perkfunctions::setfreefall, scripts\mp\perks\perkfunctions::unsetfreefall);
  registerscriptperk("_encstr_B4DB15D237DB22713140FBD7C148317BA1D85A8C15610A", scripts\mp\perks\perkfunctions::sethardshell, scripts\mp\perks\perkfunctions::unsethardshell);
  registerscriptperk("_encstr_B436149BE0B26C5A85B1A32FD7E0BDDD5993362B3663", scripts\mp\perks\perkfunctions::setpowercell, scripts\mp\perks\perkfunctions::unsetpowercell);
  registerscriptperk("_encstr_A101109B0759362DB0D83ABCEBB4B9B1DB3B", scripts\mp\perks\perkfunctions::setincog, scripts\mp\perks\perkfunctions::unsetincog);
  registerscriptperk("_encstr_AABE16C8530F9F70E70455CBDF3B7867F67A98D03AA5DB6B", scripts\mp\perks\perkfunctions::setlocaljammer, scripts\mp\perks\perkfunctions::unsetlocaljammer);
  registerscriptperk("_encstr_88B514B91CAC6C962CB11D2FF5EDCE56931BB17B8DB5", scripts\mp\perks\perkfunctions::setoverclock, scripts\mp\perks\perkfunctions::unsetoverclock);
  registerscriptperk("_encstr_B1011D12C3E0AB520F61634F1F20DBF41048CD1F58687C3A5E3973374BDA63", scripts\mp\perks\perkfunctions::setoutlinekillstreaks, scripts\mp\perks\perkfunctions::unsetoutlinekillstreaks);
  registerscriptperk("_encstr_B4DD12D237DB22713140FBD7C14B391BAF43DF0A", scripts\mp\perks\perkfunctions::setpitcher, scripts\mp\perks\perkfunctions::unsetpitcher, ["_encstr_9B2A145B1F89AF44DB704B930119FC132004D2C13E10"]);
  registerscriptperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA", scripts\mp\perks\perkfunctions::setstunresistance, scripts\mp\perks\perkfunctions::unsetstunresistance, ["_encstr_B4DB15D237DB22713140FBD7C148317BA1D85A8C15610A"]);
  registerscriptperk("_encstr_BD0612A92DDD4809EBA3C64B5BC73001B58F350B", scripts\mp\perks\perkfunctions::_encstr_99CD0CDB28C8C3AB13A8ED50F367, scripts\mp\perks\perkfunctions::_encstr_B8310EC8F643DAB32663FD7A95A8830D);
  registerscriptperk("_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728", scripts\mp\perks\perkfunctions::setoverkill, scripts\mp\perks\perkfunctions::unsetoverkill, []);
  registerscriptperk("_encstr_82B519C8530F9F70E70455CBDF033B79B5EA68211AA3F9A89F3ED5", scripts\mp\perks\perkfunctions::setbulletoutline, scripts\mp\perks\perkfunctions::unsetbulletoutline);
  registerscriptperk("_encstr_A66617F06B37B758FFECBD33C727C1519CB3C860520DF711C3", scripts\mp\perks\perkfunctions::setactivereload, scripts\mp\perks\perkfunctions::unsetactivereload);
  registerscriptperk("_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756", scripts\mp\perks\perkfunctions::setsixthsense, scripts\mp\perks\perkfunctions::unsetsixthsense);
  registerscriptperk("_encstr_88151F5F1039FB0A6391B3E810033288C188878F08D623F289B5BC696E3BEA5BE9", scripts\mp\perks\perkfunctions::setenhancedsixthsense, scripts\mp\perks\perkfunctions::unsetenhancedsixthsense);
  registerscriptperk("_encstr_B16B14F7D342A650413DA31AE92578693AEF5F4B1B7A", scripts\mp\perks\perkfunctions::setmeleekill, scripts\mp\perks\perkfunctions::unsetmeleekill);
  registerscriptperk("_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F");
  registerscriptperk("_encstr_8F7C164EEAA237C089537818B7AD997569D645C0066BE34B", scripts\mp\perks\perkfunctions::setmanatarms, scripts\mp\perks\perkfunctions::unsetmanatarms, ["_encstr_AA2514F33B2B51BB019C1071EE99BBD122276893EBA2", "_encstr_92531EE60756D82D85B18E97F5F6B395E439D24695DD2B16E0B737CD83AC9519"]);
  registerscriptperk("_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31", scripts\mp\perks\perkfunctions::setmomentum, scripts\mp\perks\perkfunctions::unsetmomentum);
  registerscriptperk("_encstr_8A0818DBB3271EE0FECC7163D724185F93BAF3815ABF458097DD", scripts\mp\perks\perkfunctions::setimprovedmelee, scripts\mp\perks\perkfunctions::unsetimprovedmelee, ["_encstr_BAC518BAA24009C4126563BBD907C003100E0DC7E7208184C5A9", "_encstr_9306169F082F68DBEFA2D37AB9DB87B00375E52B85D59015", "_encstr_A28910CDE0561B5AB0D88E5EBE1D1AB4CACC"]);
  registerscriptperk("_encstr_A28910CDE0561B5AB0D88E5EBE1D1AB4CACC", scripts\mp\perks\perkfunctions::setthief, scripts\mp\perks\perkfunctions::unsetthief);
  registerscriptperk("_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D");
  registerscriptperk("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F");
  registerscriptperk("_encstr_ACA91ACF3BE01F69593170F3B96902739A76D7C03A4690BBF64C43D8");
  registerscriptperk("_encstr_9709156E382B6C4B2C1B47F2BECC0BDCE8D89CDBBA8D34", scripts\mp\perks\perkfunctions::setfastcrouch, scripts\mp\perks\perkfunctions::unsetfastcrouch);
  registerscriptperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913", undefined, undefined, ["_encstr_AAA715470821F3025BA9BBF0181FABBDABE8A397B0D92D", "_encstr_B8331AF8E881BAC72F65FC0BA7AB528640955D8769F23DE51A3422C8"]);
  registerscriptperk("_encstr_8380190ADBF8B35A77196B57172662E47B210357B1E07AF2583F13", scripts\mp\perks\perkfunctions::setsolobuddyboost, scripts\mp\perks\perkfunctions::unsetsolobuddyboost);
  registerscriptperk("_encstr_AF911B1780B7F053671A5BE231079C908CE9A5A1075AA0A8D36251698B", scripts\mp\perks\perkfunctions::setoffhandprovider, scripts\mp\perks\perkfunctions::unsetoffhandprovider);
  registerscriptperk("_encstr_A29D16378356D85A16C63A97D7D9B14BB93A935923AB6C56");
  registerscriptperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D", scripts\mp\perks\perkfunctions::setgasgrenaderesist, scripts\mp\perks\perkfunctions::unsetgasgrenaderesist);
  registerscriptperk("_encstr_8CA016D0132B9B40F66A70638F5219197BE049E8BDE0A183", scripts\mp\perks\perkfunctions::setbattleslide, scripts\mp\perks\perkfunctions::unsetbattleslide);
  registerscriptperk("_encstr_B6731EEE28CF31B33EAAD0B071165B2B63AC7D669CA799E3E9A258B0CA2D3741", scripts\mp\perks\perkfunctions::setbattleslideoffense, scripts\mp\perks\perkfunctions::unsetbattleslideoffense);
  registerscriptperk("_encstr_A5BE1D12877FE3CC02C4DCDA6F754FCB23430710B2B7D8EFC88F19303DC469", scripts\mp\perks\perkfunctions::setbattleslideshield, scripts\mp\perks\perkfunctions::unsetbattleslideshield);
  registerscriptperk("_encstr_9BAE1A9BC1CA362DB0C63AE57D464BCD9CAE07A37B93FAE05D731B86", scripts\mp\perks\perkfunctions::setdisruptorpunch, scripts\mp\perks\perkfunctions::unsetdisruptorpunch);
  registerscriptperk("_encstr_9B2C175B1F89AF44DB704B93013F7A676388D4FFB790BFCD89", scripts\mp\perks\perkfunctions::setgroundpound, scripts\mp\perks\perkfunctions::unsetgroundpound);
  registerscriptperk("_encstr_BD2F1EFA2B08438AA7C9DBE7475CC3B76070B749837B1DB20D97DF5B33756AF4", scripts\mp\perks\perkfunctions::setgroundpoundshield, scripts\mp\perks\perkfunctions::unsetgroundpoundshield);
  registerscriptperk("_encstr_A7481D63F138CEBFAFA86BA3D6F49B85C0A5ECC749C0935BC5E613BAB8DE27", scripts\mp\perks\perkfunctions::setgroundpoundshock, scripts\mp\perks\perkfunctions::unsetgroundpoundshock);
  registerscriptperk("_encstr_97D713A7F33FFEA116B04BD0DFD34C5A954F393755", scripts\mp\perks\perkfunctions::setthruster, scripts\mp\perks\perkfunctions::unsetthruster);
  registerscriptperk("_encstr_B81110A3BB62F9185E446489AF03B783F70D", scripts\mp\perks\perkfunctions::setdodge, scripts\mp\perks\perkfunctions::unsetdodge);
  registerscriptperk("_encstr_B18416571831C3326B99ABE0681B5B9CBB086FB348C93F3A", scripts\mp\perks\perkfunctions::setextradodge, scripts\mp\perks\perkfunctions::unsetextradodge);
  registerscriptperk("_encstr_84991796F7C73221270DB348F83A90BB47375C31753058D22B", scripts\mp\perks\perkfunctions::setextenddodge, scripts\mp\perks\perkfunctions::unsetextenddodge);
  registerscriptperk("_encstr_ABAE16CD072BC696B063A3BCAFC143859B56D737B12D2395", scripts\mp\perks\perkfunctions::setphaseslide, scripts\mp\perks\perkfunctions::unsetphaseslide);
  registerscriptperk("_encstr_8E9E15CD1C59364B0B1BA32FD7E85636CABE378D5A912B", scripts\mp\perks\perkfunctions::setteleslide, scripts\mp\perks\perkfunctions::unsetteleslide);
  registerscriptperk("_encstr_815A155F7BEA0E88A9D55BF23180B8B723B7D799D75343", undefined, undefined, ["_encstr_A1111D38A3FF6F8037D4857B8F1BE833225A80482A92B19E43C58FFB89CFB1"]);
  registerscriptperk("_encstr_A1111D38A3FF6F8037D4857B8F1BE833225A80482A92B19E43C58FFB89CFB1", scripts\mp\perks\perkfunctions::setphaseslashrephase, scripts\mp\perks\perkfunctions::unsetphaseslashrephase);
  registerscriptperk("_encstr_844A15DCE0B2364B2C3647BCBE831A2CCDACFA33C21BC6", scripts\mp\perks\perkfunctions::setphasefall, scripts\mp\perks\perkfunctions::unsetphasefall);
  registerscriptperk("_encstr_8277193778516392CB390B4088F36B3A7999B757D8C9D3FB0F4712", scripts\mp\perks\perkfunctions::setauraquickswap, scripts\mp\perks\perkfunctions::unsetauraquickswap);
  registerscriptperk("_encstr_8A4915DC8356D82D85C6E8CBAFB0EA270BAFB9E0ACCA19", scripts\mp\perks\perkfunctions::setauraspeed, scripts\mp\perks\perkfunctions::unsetauraspeed);
  registerscriptperk("_encstr_BE23175B0F15D86F8621F59A275D8FCB22D71B6EEB9FCF89A0", scripts\mp\perks\perkfunctions::setmarktargets, scripts\mp\perks\perkfunctions::unsetmarktargets);
  registerscriptperk("_encstr_BD3D166EE0B2D8A5C28D8EE5AF13B0D1E8959CBC388536B6", scripts\mp\perks\perkfunctions::setbatterypack, scripts\mp\perks\perkfunctions::unsetbatterypack);
  registerscriptperk("_encstr_93EC15672801D3227B89DB907827FA95E8E9B78308DB0D", scripts\mp\perks\perkfunctions::setcamoelite, scripts\mp\perks\perkfunctions::unsetcamoelite);
  registerscriptperk("_encstr_B63B1AE6832BD8D2B036475EBEDC6CBDE4CA6E47E4950BDA0EB0B15B", scripts\mp\perks\perkfunctions::setscorestreakpack, scripts\mp\perks\perkfunctions::unsetscorestreakpack);
  registerscriptperk("_encstr_B4BF146E1CCAB1A5C2B13ACBAFB9AB832B9C070BC66D", scripts\mp\perks\perkfunctions::setsuperpack, scripts\mp\perks\perkfunctions::unsetsuperpack);
  registerscriptperk("_encstr_864E18A373482BFBE0426B73E901E01350AFE1FA9548A238835D", scripts\mp\perks\perkfunctions::setdodgedefense, scripts\mp\perks\perkfunctions::unsetdodgedefense);
  registerscriptperk("_encstr_ACAE15AFAB97EF304782E35148836AB0EBAEA17177491A", scripts\mp\perks\perkfunctions::setspawncloak, scripts\mp\perks\perkfunctions::unsetspawncloak);
  registerscriptperk("_encstr_834A13DC0ECA1BD20B1B3ACBD76CDED65B857319B7");
  registerscriptperk("_encstr_A5C01AE3EF4F42B88221EB1BD10AF1453BF8D84E10372BDA4287A0B1", scripts\mp\perks\perkfunctions::setpersonaltrophy, scripts\mp\perks\perkfunctions::unsetpersonaltrophy);
  registerscriptperk("_encstr_9277192390DBD6AF29C98C894871179B6B284ADA088181832D2067", scripts\mp\perks\perkfunctions::setequipmentping, scripts\mp\perks\perkfunctions::unsetequipmentping, ["_encstr_9AFE106EE0B2D8B42CD8A397BEE058A59BE8"]);
  registerscriptperk("_encstr_A226104293B0FB023F51539FCFD69A3F4858", scripts\mp\perks\perkfunctions::setcloak, scripts\mp\perks\perkfunctions::unsetcloak);
  registerscriptperk("_encstr_A18D14E6072BD85A858DD12FAFBBB0361BBE8DDED86D", scripts\mp\perks\perkfunctions::setwalllock, scripts\mp\perks\perkfunctions::unsetwalllock);
  registerscriptperk("_encstr_B6B30F079087C063570A4B92416325089C", scripts\mp\perks\perkfunctions::setrush, scripts\mp\perks\perkfunctions::unsetrush);
  registerscriptperk("_encstr_B81410535F4942F8731823EB8718E73B32F5", scripts\mp\perks\perkfunctions::sethover, scripts\mp\perks\perkfunctions::unsethover);
  registerscriptperk("_encstr_A96818DC38566CB4858D8E2FD79B8D1667ACDC9D59E4F52B5CC1", scripts\mp\perks\perkfunctions::setscavengereqp, scripts\mp\perks\perkfunctions::unsetscavengereqp);
  registerscriptperk("_encstr_834714AA90A339D739C9B35009B3AAC76823E8592D7F", scripts\mp\perks\perkfunctions::setspawnview, scripts\mp\perks\perkfunctions::unsetspawnview);
  registerscriptperk("_encstr_8A2913B91C596C2DB0B18E977D1A560B46D9952C27", scripts\mp\perks\perkfunctions::setheadgear, scripts\mp\perks\perkfunctions::unsetheadgear);
  registerscriptperk("_encstr_B25613DC1C59D82D85368EBCD79947C66EC65A19CA", scripts\mp\perks\perkfunctions::setftlslide, scripts\mp\perks\perkfunctions::unsetftlslide);
  registerscriptperk("_encstr_AF4E196E83566CD2C2B1A397F596B6074EBDB35919FA074EBDB9B2", scripts\mp\perks\perkfunctions::setimprovedprone, scripts\mp\perks\perkfunctions::unsetimprovedprone);
  registerscriptperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E", scripts\mp\perks\perkfunctions::setsupportkillstreaks, scripts\mp\perks\perkfunctions::unsetsupportkillstreaks);
  registerscriptperk("_encstr_92531EE60756D82D85B18E97F5F6B395E439D24695DD2B16E0B737CD83AC9519", scripts\mp\perks\perkfunctions::setoverrideweaponspeed, scripts\mp\perks\perkfunctions::unsetoverrideweaponspeed);
  registerscriptperk("_encstr_B128170EC82FD1139E0A7010113621E8974B808F35AB584B85", scripts\mp\perks\perkfunctions::setcloakaerial, scripts\mp\perks\perkfunctions::unsetcloakaerial);
  registerscriptperk("_encstr_925416E7C995124910981358166898CA741DCF6B534D7A2A", scripts\mp\perks\perkfunctions::setspawnradar, scripts\mp\perks\perkfunctions::unsetspawnradar);
  registerscriptperk("_encstr_962018A2474BB2E1A1F04B475199A4FB67572B5E2EE3DA350BE0", scripts\mp\perks\perkfunctions::setadsawareness, scripts\mp\perks\perkfunctions::unsetadsawareness);
  registerscriptperk("_encstr_AFC0140F210D8AD1B820BBC07E18E5625E979FBFCD25", scripts\mp\perks\perkfunctions::setrearguard, scripts\mp\perks\perkfunctions::unsetrearguard);
  registerscriptperk("_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363", scripts\mp\perks\perkfunctions::setsharpfocus, scripts\mp\perks\perkfunctions::unsetsharpfocus);
  registerscriptperk("_encstr_BE13109B83ACC6B40BC6E85E7DC41B2DCD3B");
  registerscriptperk("_encstr_A9011187A332D620116DF3AA59FBD819EA2B39", scripts\mp\perks\perkfunctions::setcomexp, scripts\mp\perks\perkfunctions::unsetcomexp);
  registerscriptperk("_encstr_9AFE106EE0B2D8B42CD8A397BEE058A59BE8");
  registerscriptperk("_encstr_BA37147FF327FF6B6FE518910FA9D8CADE7029193308");
  registerscriptperk("_encstr_AC6517104BEDE9536A6D55DB8963A19151B3D808578DC35D52", scripts\mp\perks\perkfunctions::setsteadyaimpro, scripts\mp\perks\perkfunctions::unsetsteadyaimpro);
  registerscriptperk("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6", scripts\mp\perks\perkfunctions::setblockhealthregen, scripts\mp\perks\perkfunctions::unsetblockhealthregen);
  registerscriptperk("_encstr_AA2817F33B2B51BB019C1071EE7B3EE9E4376381D542BA9F83", scripts\mp\perks\perkfunctions::setrshieldradar, scripts\mp\perks\perkfunctions::unsetrshieldradar);
  registerscriptperk("_encstr_81B51BD237DB22713140FBD7C10B23DABBC59D8F1E7FEB81581893AFC0", scripts\mp\perks\perkfunctions::setrshieldscrambler, scripts\mp\perks\perkfunctions::unsetrshieldscrambler);
  registerscriptperk("_encstr_AC11173F08972B182333F88A89BD3551FE9AA4C388352C50DF");
  registerscriptperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3");
  registerscriptperk("_encstr_9949151BA8E3FE87312164715099578515C8F322D84F74", scripts\mp\perks\perkfunctions::setcombathigh, scripts\mp\perks\perkfunctions::unsetcombathigh);
  registerscriptperk("_encstr_ACBC11F347D1F72CB30823CBA99D639749A56C", scripts\mp\perks\perkfunctions::setjuiced, scripts\mp\perks\perkfunctions::unsetjuiced);
  registerscriptperk("_encstr_BA3F126337A1875CC398B37B193D971B1990FFED", scripts\mp\perks\perkfunctions::setrevenge, scripts\mp\perks\perkfunctions::unsetrevenge);
  registerscriptperk("_encstr_A6F416234BDFF6086654D9DB7F0D404C53A33EE9931738E8", scripts\mp\perks\perkfunctions::setlightarmor, scripts\mp\perks\perkfunctions::unsetlightarmor);
  registerscriptperk("_encstr_82B216A331F80E7F6F68AB6316B697822BD9293BBF705737", scripts\mp\perks\perkfunctions::setcarepackage, scripts\mp\perks\perkfunctions::unsetcarepackage);
  registerscriptperk("_encstr_91201942101D511B7FC0CB0909766B10F15111581F914A123F235A");
  registerscriptperk("_encstr_92360ED7F9A522790B88E3A80648B9AB", scripts\mp\perks\perkfunctions::setuav, scripts\mp\perks\perkfunctions::unsetuav);
  registerscriptperk("_encstr_BE3F1BD740773093A7DA9B22F1235BC80BA36B6FF35DC0ED83133089BA", scripts\mp\perks\perkfunctions::setviewkickoverride, scripts\mp\perks\perkfunctions::unsetviewkickoverride);
  registerscriptperk("_encstr_84621D5B1F89AF44DB704B9301337F43E088D9D43313AB0F8B08320A982FB3", scripts\mp\perks\perkfunctions::setaffinityspeedboost, scripts\mp\perks\perkfunctions::unsetaffinityspeedboost);
  registerscriptperk("_encstr_8D06206EC1956C2D16D83ABCFA85CC334BE65A475EB23CD19CC263165DB96C3495E4", scripts\mp\perks\perkfunctions::setaffinityextralauncher, scripts\mp\perks\perkfunctions::unsetaffinityextralauncher);
  registerscriptperk("_encstr_873F11B51F3318D6C7BAB90112EB15E8C16519");
  registerscriptperk("_encstr_9AAE0876FCB7603101DB");
  registerscriptperk("_encstr_ACC40CC1F8A321601715CFBFE0EA");
  registerscriptperk("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  registerscriptperk("_encstr_92A70ABB8267F5E0D89F6351");
  registerscriptperk("_encstr_8592135EB163BBE43908DF372011A6C2295D295527");
  registerscriptperk("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83");
  registerscriptperk("_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83");
  registerscriptperk("_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170");
  registerscriptperk("_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA");
  registerscriptperk("_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1");
  registerscriptperk("_encstr_96D117C193B71E4BB5A547BCF5CA1E83C6BD37A59D56FA5B38");
  registerscriptperk("_encstr_AA8F0D866E03FBC64A9F7013776DFB");
  registerscriptperk("_encstr_964810F7F0603827968B0F3E47800E4FBFF0");
  registerscriptperk("_encstr_86121E3BCBD24FDB404B1DD191AA73B37C1BD7C4D20608E32315CF2F8EF7E7ED", scripts\mp\perks\perkfunctions::setthrowingknifemelee, scripts\mp\perks\perkfunctions::unsetthrowingknifemelee);
  registerscriptperk("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B");
  registerscriptperk("_encstr_AA87121EFF424770EAEFB010EF1E49911AE99927");
  registerscriptperk("_encstr_AC9E13EF0EFB5B29CB802FC7F0C11692592D79E5F7");
  registerscriptperk("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683");
  registerscriptperk("_encstr_8823119675DAFF897F878020BB99612B219D8F");
  registerscriptperk("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E");
  registerscriptperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8", scripts\mp\perks\perkfunctions::settacticalinsertion, scripts\mp\perks\perkfunctions::unsettacticalinsertion);
  registerscriptperk("_encstr_92EA0A290B32FF88A90170EB");
  registerscriptperk("_encstr_ABC111DAF6D14BDB9BBEB9B2CDE6BD9CF56B07");
  registerscriptperk("_encstr_848B1005B77834C3C596A39A192F6361A831");
  registerscriptperk("_encstr_BDC9145E757AAF080F8FF0B1DF4A81FD021F45488DC3");
  registerscriptperk("_encstr_A6010E483BC08B13FF485587B1E9DB2B");
  registerscriptperk("_encstr_8B76125B2A543086C2379FBDF78AC7A0F549ADB3");
  registerscriptperk("_encstr_AAE60D90523A6F0173CD06F38F6FEB");
  registerscriptperk("_encstr_91490C85B66B7BFA89BD3CBED683");
  registerscriptperk("_encstr_8B2C0C588A169738FB015DC01543");
  registerscriptperk("_encstr_B635099C3C8FEDFB88E9EB");
  registerscriptperk("_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8", undefined, undefined, ["_encstr_BD0612A92DDD4809EBA3C64B5BC73001B58F350B", "_encstr_B26F1B5A8BA8E3EAC7A9BB87E7FDC34C2BD017A761B0AD722D430F9729", "_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3", "_encstr_A7140F937898399A89DBB96DC863D2C5E3"]);
  var_0 = scripts\mp\passives::getweapontypepassives();

  foreach(var_2 in var_0) {
    level.scriptperks[var_2] = 1;
    var_3 = scripts\mp\passives::getpassiveperk(var_2);

    if(isDefined(var_3))
      level.extraperkmap[var_2] = [var_3];
  }

  registerscriptperk("_encstr_AC9C0FEA0FF30A29692883BF99A00D4249");
  registercodeperkinfo("_encstr_9AB512B907CA8DA5C2638EF2FA1D86CAC9B60BD8", scripts\mp\perks\perkfunctions::setthermal, scripts\mp\perks\perkfunctions::unsetthermal);
  registercodeperkinfo("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8", scripts\mp\perks\perkfunctions::setlightweight, scripts\mp\perks\perkfunctions::unsetlightweight);
  registercodeperkinfo("_encstr_BE8816F3BA98B62BD308235FA61B6DB0030818672BE317E3", scripts\mp\perks\perkfunctions::setsteelnerves, scripts\mp\perks\perkfunctions::unsetsteelnerves);
  registercodeperkinfo("_encstr_882C139B1C598DD258B13A2FD7DC2C4CDBD195AB27", scripts\mp\perks\perkfunctions::setsaboteur, scripts\mp\perks\perkfunctions::unsetsaboteur);
  registercodeperkinfo("_encstr_A7CF1212F71BE2B1F1803B1701A97E5AE7871D0F", scripts\mp\perks\perkfunctions::setendgame, scripts\mp\perks\perkfunctions::unsetendgame);
  registercodeperkinfo("_encstr_AFED1583D74167BC23B8935B39673537383716096EE8D7", scripts\mp\perks\perkfunctions::setonemanarmy, scripts\mp\perks\perkfunctions::unsetonemanarmy);
  registercodeperkinfo("_encstr_9B1316E2078B722161308B87919BE59A79102DDD670FAA62", scripts\mp\perks\perkfunctions::setweaponlaser, scripts\mp\perks\perkfunctions::unsetweaponlaser);
  registercodeperkinfo("_encstr_8AA21393E26518B31AA3F1D357E28FD833BAD8A90D", scripts\mp\perks\perkfunctions::setmarksman, scripts\mp\perks\perkfunctions::unsetmarksman);
  registercodeperkinfo("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A", undefined, undefined);
  registercodeperkinfo("_encstr_8FDB18C848526E611FB1D0C8399337AC697DCEBF5F419B118B02", undefined, undefined);
  registercodeperkinfo("_encstr_9306169F082F68DBEFA2D37AB9DB87B00375E52B85D59015", undefined, undefined);
  registercodeperkinfo("_encstr_A35C168FA18D0A5138A03B40FE286FA3D6015FC771209214", scripts\mp\perks\perkfunctions::setdoubleload, scripts\mp\perks\perkfunctions::unsetdoubleload);
  registercodeperkinfo("_encstr_8AB61772403D1B03A14DC8F0562F6B1AC27F3A9D7ABFA2CAB7", scripts\mp\perks\perkfunctions::setoverkillpro, scripts\mp\perks\perkfunctions::unsetoverkillpro);
  registercodeperkinfo("_encstr_A7851ACD1C9536961663A3BCAF4E59CC96C6D8AFCE392BDC5819CAB9", scripts\mp\perks\perkfunctions::setrefillgrenades, scripts\mp\perks\perkfunctions::unsetrefillgrenades);
  registercodeperkinfo("_encstr_8C0B160B9950A627378DD30B4E962F5F98399C5FD3486DF7", scripts\mp\perks\perkfunctions::setrefillammo, scripts\mp\perks\perkfunctions::unsetrefillammo);
  registercodeperkinfo("_encstr_A29B17CBC8055BDAFEA0431B99AAD73F02231B51EF8B215DB3", scripts\mp\perks\perkfunctions::setcombatspeed, scripts\mp\perks\perkfunctions::unsetcombatspeed);
  registercodeperkinfo("_encstr_A620114F8329EB1A53A183F8AF51D2B731C033", scripts\mp\perks\perkfunctions::settagger, scripts\mp\perks\perkfunctions::unsettagger);
  registercodeperkinfo("_encstr_A7EC17BF91DD5A0168D04B10AE9842B2A4C76F230977B3D040", scripts\mp\perks\perkfunctions::settriggerhappy, scripts\mp\perks\perkfunctions::unsettriggerhappy);
  registercodeperkinfo("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7", scripts\mp\perks\perkfunctions::setblindeye, scripts\mp\perks\perkfunctions::unsetblindeye);
  registercodeperkinfo("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F", scripts\mp\perks\perkfunctions::setquickswap, scripts\mp\perks\perkfunctions::unsetquickswap, ["_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045"]);
  registercodeperkinfo("_encstr_B1C71A568067992BA6C2A8D8E97FC1B38339C8C5F94F80218DBA70B8", scripts\mp\perks\perkfunctions::setextraequipment, scripts\mp\perks\perkfunctions::unsetextraequipment);
  registercodeperkinfo("_encstr_83D013DC07B28D96B0B147E5D78D2D33B20716C65B", scripts\mp\perks\perkfunctions::setlifepack, scripts\mp\perks\perkfunctions::unsetlifepack);
  registercodeperkinfo("_encstr_8EF914635BE5D70468B104013F284D771CB09A3A43C7", scripts\mp\perks\perkfunctions::settoughenup, scripts\mp\perks\perkfunctions::unsettoughenup);
  registercodeperkinfo("_encstr_8EDA1487B3BB47A353FD5370AFDB9E8778CB53605E30", scripts\mp\perks\perkfunctions::setscoutping, scripts\mp\perks\perkfunctions::unsetscoutping);
  registercodeperkinfo("_encstr_8CD1166E38CAB15A588D1D97FA8343C2DC597DDCC156AC19", scripts\mp\perks\perkfunctions::setphasespeed, scripts\mp\perks\perkfunctions::unsetphasespeed);
  registercodeperkinfo("_encstr_B81615535F4942F8731823EB8740DF5792AF169B95209D", scripts\mp\perks\perkfunctions::setcamoclone, scripts\mp\perks\perkfunctions::unsetcamoclone);
  registercodeperkinfo("_encstr_92AB1A57FFB5FF5061740B38D954371803F86B6D0BF767B0F220BA87", undefined, undefined, ["_encstr_A90D16E60EB2B15A1636D1CB7DC9CA46D56C2BC86EBBB05E"]);
  registercodeperkinfo("_encstr_AAA715470821F3025BA9BBF0181FABBDABE8A397B0D92D", scripts\mp\perks\perkfunctions::setovercharge, scripts\mp\perks\perkfunctions::unsetovercharge);
  registercodeperkinfo("_encstr_AC191F77E0D7903307BAFB429197F5C06F5AFFE98ABCA085D7C2B0685A8BA6D0C7", scripts\mp\perks\perkfunctions::setsupersprintenhanced, scripts\mp\perks\perkfunctions::unsetsupersprintenhanced);
  registercodeperkinfo("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9", scripts\mp\perks\perkfunctions::setnoscopeoutline, scripts\mp\perks\perkfunctions::unsetnoscopeoutline);
  registercodeperkinfo("_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B");
  initperkdvars();
  menurigperkparsetable();
  menuperkparsetable();
  initperktable();
  level thread onplayerconnect();
}

registerscriptperk(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 1, var_1, var_2, var_3);
}

registercodeperkinfo(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 0, var_1, var_2, var_3);
}

registerperk(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1))
    level.scriptperks[var_0] = 1;

  if(isDefined(var_2))
    level.perksetfuncs[var_0] = var_2;

  if(isDefined(var_3))
    level.perkunsetfuncs[var_0] = var_3;

  if(isDefined(var_4))
    level.extraperkmap[var_0] = var_4;
}

menurigperkparsetable() {
  if(!isDefined(level.menurigperks))
    level.menurigperks = [];

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A11414DA0E97DAAC37D592A53B282B9CAD6E71C6CDB3", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_A11414DA0E97DAAC37D592A53B282B9CAD6E71C6CDB3", var_0, 1);
    var_3 = tablelookupbyrow("_encstr_A11414DA0E97DAAC37D592A53B282B9CAD6E71C6CDB3", var_0, 2);
    var_4 = spawnStruct();
    var_4.id = var_1;
    var_4.ref = var_3;
    var_4.archetype = var_2;

    if(!isDefined(level.menurigperks[var_3]))
      level.menurigperks[var_3] = var_4;

    var_0++;
  }
}

menuperkparsetable() {
  if(!isDefined(level.menuperks))
    level.menuperks = [];

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_AF3411DD97481FFF7D3091DA10AFB2DA39FE4E", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_AF3411DD97481FFF7D3091DA10AFB2DA39FE4E", var_0, 1);
    var_3 = tablelookupbyrow("_encstr_AF3411DD97481FFF7D3091DA10AFB2DA39FE4E", var_0, 2);
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.ref = var_3;
    var_4.slot = var_2;

    if(!isDefined(level.menuperks[var_3]))
      level.menuperks[var_3] = var_4;

    var_0++;
  }
}

initperktable() {
  if(!isDefined(level.perktable))
    level.perktable = [];

  level.perksbyid = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A3B11105673F630D23282B079818C54E7F7E4B", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_A3B11105673F630D23282B079818C54E7F7E4B", var_0, 1);
    var_3 = tablelookupbyrow("_encstr_A3B11105673F630D23282B079818C54E7F7E4B", var_0, 16);
    var_4 = tablelookupbyrow("_encstr_A3B11105673F630D23282B079818C54E7F7E4B", var_0, 17);
    var_5 = tablelookupbyrow("_encstr_A3B11105673F630D23282B079818C54E7F7E4B", var_0, 18);
    var_6 = spawnStruct();
    var_6.ref = var_2;
    var_6.id = int(var_1);
    var_6.specialist = int(var_3);
    var_6._id_136D1 = int(var_4);

    if(var_5 != "_encstr_B40101")
      game["_encstr_B2DA070A5F8BAB87AF"][var_2] = var_5;

    if(!isDefined(level.perktable[var_2]))
      level.perktable[var_2] = var_6;

    level.perksbyid[var_6.id] = var_6.ref;
    var_0++;
  }
}

initspecialistkillstreaks() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_96AF127BC7026103B6E82B336B116240E3833979", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_AAAF12036BFFD628063483AF34E1A8ADDBB21EA3", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_81AF120B0297F6342960F003808FB803ED284F33", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8A0F16B7C8A936CB116ADA5265E973273A603182270EDB4B", undefined, ::_id_1208E);
}

onspecialistkillstreakavailable(var_0) {
  var_1 = getspecialistperkforstreak(var_0.streakname);
  scripts\mp\utility\perk::giveperk(var_1);
}

getspecialistperkforstreak(var_0) {
  var_1 = getspecialistindexforstreak(var_0);

  if(var_1 == -1)
    return undefined;

  return self.classstruct.loadoutextraperks[var_1];
}

getspecialistindexforstreak(var_0) {
  if(!isDefined(var_0))
    return -1;

  if(var_0 == "_encstr_96AF127BC7026103B6E82B336B116240E3833979")
    return 0;
  else if(var_0 == "_encstr_AAAF12036BFFD628063483AF34E1A8ADDBB21EA3")
    return 1;
  else if(var_0 == "_encstr_81AF120B0297F6342960F003808FB803ED284F33")
    return 2;
  else
    return -1;
}

usescriptablemeleeblood(var_0) {
  switch (var_0) {
    case "_encstr_8A0F16B7C8A936CB116ADA5265E973273A603182270EDB4B":
    case "_encstr_81AF120B0297F6342960F003808FB803ED284F33":
    case "_encstr_AAAF12036BFFD628063483AF34E1A8ADDBB21EA3":
    case "_encstr_96AF127BC7026103B6E82B336B116240E3833979":
      return 1;
    default:
      return 0;
  }
}

_id_1208E(var_0) {
  bears();
}

battle_tracks_tryinittogglestate(var_0) {
  switch (var_0) {
    case "_encstr_957407BAC223B9F05B":
      big_door_watcher();
      break;
    case "_encstr_8419044EB232":
      battletracksowner();
      break;
    case "_encstr_B29B0550F33591":
      battle_tracks_gettrackindex();
      break;
    case "_encstr_B40101":
      break;
    default:
      scripts\mp\utility\perk::giveperk(var_0);
      break;
  }
}

hudcost(var_0) {
  if(issubstr(var_0, "_encstr_96831341CAC5CF07955E03424E18D14B4F90183941")) {
    var_1 = getsubstr(var_0, 18);

    switch (var_1) {
      case "_encstr_AFC206471B87EADC":
        return "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC";
      case "_encstr_951610DE7ECBD43B97312B9ECBDB0755A5DF":
        return "_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8";
      case "_encstr_A21F0D3A6F90DA80E3BF50E7BA97A5":
        return "_encstr_91111BD740773093A7DA9B22F173D6198EAC556BF65E586D8702F0ABAB";
      case "_encstr_8CFF09D56D88EC030D69EB":
        return "_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735";
      case "_encstr_915309A318E37752A6D70A":
        return "_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6";
      case "_encstr_BDE90813CB232569D3F8":
        return "_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733";
      case "_encstr_AA2908837B2351BF8182":
        return "_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB";
      case "_encstr_ADF80637DB2FC38C":
        return "_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2";
      case "_encstr_8287091A0B3919C65A37CA":
        return "_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F";
      case "_encstr_B1810BB85F9FF84FFAFD6DEED3":
        return "_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95";
      case "_encstr_91AE093D2BC8926A63097B":
        return "_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765";
      case "_encstr_8D1A090EBDA59B3AB685DC":
        return "_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8";
      case "_encstr_8A29083959DC8EEDB1AD":
        return "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F";
      case "_encstr_A91609CB30B05072CD9D2F":
        return "_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32";
      case "_encstr_86260A236B37DB6FC9384B7A":
        return "_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C";
      case "_encstr_85E60D019ADB5599C6348F97246F08":
        return "_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F";
      case "_encstr_8E140C89F2D7CE98AFAF0133B597":
        return "_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B";
      case "_encstr_8B1804DF30C1":
        return "_encstr_9A360EC74F39AA043E1D2333C71D30C3";
      case "_encstr_A5840B12DA94BB31F824C33B08":
        return "_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871";
      case "_encstr_AF460A7B2649F34FE367455D":
        return "_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6";
      case "_encstr_ACC50BC3D98528611519CC7BE1":
        return "_encstr_823218E6832B1B96C2B1A3E5BE989CFACDB2270ECAB9A3A5B956";
      case "_encstr_B29B0550F33591":
      case "_encstr_957407BAC223B9F05B":
      case "_encstr_8419044EB232":
        return var_1;
      default:
        return "_encstr_B40101";
    }
  } else
    return "_encstr_B40101";
}

big_door_watcher() {
  scripts\mp\utility\perk::giveperk("_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC");
  scripts\mp\utility\perk::giveperk("_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8");
  scripts\mp\utility\perk::giveperk("_encstr_91111BD740773093A7DA9B22F173D6198EAC556BF65E586D8702F0ABAB");
  scripts\mp\utility\perk::giveperk("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735");
  scripts\mp\utility\perk::giveperk("_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6");
  scripts\mp\utility\perk::giveperk("_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733");
  scripts\mp\utility\perk::giveperk("_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB");
}

battletracksowner() {
  scripts\mp\utility\perk::giveperk("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2");
  scripts\mp\utility\perk::giveperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F");
  scripts\mp\utility\perk::giveperk("_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95");
  scripts\mp\utility\perk::giveperk("_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765");
  scripts\mp\utility\perk::giveperk("_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8");
  scripts\mp\utility\perk::giveperk("_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F");
  scripts\mp\utility\perk::giveperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32");
}

battle_tracks_gettrackindex() {
  scripts\mp\utility\perk::giveperk("_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C");
  scripts\mp\utility\perk::giveperk("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F");
  scripts\mp\utility\perk::giveperk("_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B");
  scripts\mp\utility\perk::giveperk("_encstr_9A360EC74F39AA043E1D2333C71D30C3");
  scripts\mp\utility\perk::giveperk("_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871");
  scripts\mp\utility\perk::giveperk("_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6");
}

bears() {
  foreach(var_1 in level.perktable) {
    var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB", istrue(var_1._id_136D1), istrue(var_1.specialist));

    if(!var_2) {
      continue;
    }
    if(equipmentisrestricted(var_1.ref)) {
      continue;
    }
    scripts\mp\utility\perk::giveperk(var_1.ref);
  }

  scripts\mp\utility\perk::giveperk("_encstr_A6F51B234BDFF6086654D9DB7FCA884D7F72F948226FB581FE3FE5CB7B");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    return;
  }
  scripts\mp\utility\perk::giveperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::giveperk("_encstr_BE321990CB6D69D3EAEDD55B09C21310DFDFB0C8BF0101E1B29544");
    scripts\mp\utility\perk::giveperk("_encstr_AC11173F08972B182333F88A89BD3551FE9AA4C388352C50DF");
    scripts\mp\utility\perk::giveperk("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F");
    scripts\mp\utility\perk::giveperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3");
    scripts\mp\utility\perk::giveperk("_encstr_8AA21393E26518B31AA3F1D357E28FD833BAD8A90D");
    scripts\mp\utility\perk::giveperk("_encstr_8CED153FA88FC87B4F02339A593F2DF8621585871F3098");
  }
}

_id_12C25() {
  foreach(var_1 in level.perktable) {
    var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB", istrue(var_1._id_136D1), istrue(var_1.specialist));

    if(!var_2) {
      continue;
    }
    if(equipmentisrestricted(var_1.ref)) {
      continue;
    }
    scripts\mp\utility\perk::removeperk(var_1.ref);
  }

  scripts\mp\utility\perk::removeperk("_encstr_A6F51B234BDFF6086654D9DB7FCA884D7F72F948226FB581FE3FE5CB7B");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    return;
  }
  scripts\mp\utility\perk::removeperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
  scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::removeperk("_encstr_BE321990CB6D69D3EAEDD55B09C21310DFDFB0C8BF0101E1B29544");
    scripts\mp\utility\perk::removeperk("_encstr_AC11173F08972B182333F88A89BD3551FE9AA4C388352C50DF");
    scripts\mp\utility\perk::removeperk("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F");
    scripts\mp\utility\perk::removeperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3");
    scripts\mp\utility\perk::removeperk("_encstr_8AA21393E26518B31AA3F1D357E28FD833BAD8A90D");
    scripts\mp\utility\perk::removeperk("_encstr_8CED153FA88FC87B4F02339A593F2DF8621585871F3098");
  }
}

getavailableperks() {
  var_0 = [];

  foreach(var_2 in level.menuperks) {
    if(scripts\mp\utility\perk::_hasperk(var_2.name)) {
      continue;
    }
    var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

getperkslot(var_0) {
  var_1 = level.menuperks[var_0];

  if(!isDefined(var_1))
    return undefined;

  return int(var_1.slot);
}

validateperk(var_0) {
  if(!scripts\mp\utility\perk::perksenabled())
    var_0 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  else {
    switch (var_0) {
      case "_encstr_9AD81737E0ACB1D2B0C6472FFA6CF639389BACD737D159B08D":
      case "_encstr_AF0519C89335219B52250D93F12AC129915321582FC9F969FA8D08":
      case "_encstr_8E621237838FB6EB8F12ABEA513422A381ED81E5":
      case "_encstr_913212DC0E2BB15A161BE8F27DCE0BAD9863ACC9":
      case "_encstr_9A871B9BA008488198DBDB8B56AADD04615713F4EB11F882C28BC8D057":
      case "_encstr_8EA61ACBA3372ED0CEFC61732777486DDF0AA3B18B3BD1A862C17DB3":
      case "_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27":
      case "_encstr_A1C919E233105BA29FF1F3FFAF36AB9C8079DBEEC988F54BE787CF":
      case "_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218":
      case "_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858":
      case "_encstr_A78914C159C9B607161B5BB0B3ACD76E07F6E83ACA39":
      case "_encstr_AF7816784B5ADAC3A15B94F1A4505722DD602043111DF2A7":
      case "_encstr_88E614E392AB6DEB27AE6488EFFA6137B9C0486183F0":
      case "_encstr_95DD180B5F7A50370297F7EBAF6AE8700535908DC4C488600ACF":
      case "_encstr_AFDB14072B275B1CC28DB6853BACAF9BD50E83F69347":
      case "_encstr_B29F15530A93E2D0162B97FB577FE1B6D7D32BF8A30FA6":
      case "_encstr_BA741310BBFEF8B862C750389742877319DE34519E":
      case "_encstr_A90D16E60EB2B15A1636D1CB7DC9CA46D56C2BC86EBBB05E":
      case "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249":
      case "_encstr_A9011187A332D620116DF3AA59FBD819EA2B39":
      case "_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363":
      case "_encstr_9AFE106EE0B2D8B42CD8A397BEE058A59BE8":
      case "_encstr_B4BF146E1CCAB1A5C2B13ACBAFB9AB832B9C070BC66D":
      case "_encstr_B63B1AE6832BD8D2B036475EBEDC6CBDE4CA6E47E4950BDA0EB0B15B":
      case "_encstr_BD3D166EE0B2D8A5C28D8EE5AF13B0D1E8959CBC388536B6":
      case "_encstr_84991796F7C73221270DB348F83A90BB47375C31753058D22B":
      case "_encstr_B18416571831C3326B99ABE0681B5B9CBB086FB348C93F3A":
      case "_encstr_8CA016D0132B9B40F66A70638F5219197BE049E8BDE0A183":
      case "_encstr_A66617F06B37B758FFECBD33C727C1519CB3C860520DF711C3":
      case "_encstr_B4DD12D237DB22713140FBD7C14B391BAF43DF0A":
      case "_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959":
      case "_encstr_AA2514F33B2B51BB019C1071EE99BBD122276893EBA2":
      case "_encstr_97D21AA7F33FFEA116B04BD0DF9748DA8C3F37345D59DD39B0531F07":
      case "_encstr_86370FAF8B1AFE183945EB42A1E2F02072":
      case "_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7":
      case "_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392":
      case "_encstr_92D3177FE8CF883B0F42F35A99AFEDC86742F1DB617290F02F":
      case "_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756":
      case "_encstr_A2821B5F1039FB0A6391B3E810112283C158AFA758D63D729D3AFC2564":
      case "_encstr_B2D9157B3B83979FA3E9BB803F12D0D850B11840DE4275":
      case "_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF":
      case "_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693":
      case "_encstr_BD0E1962B390DB221F71737F2F366A1E99191FE16B38767AEC0B3B":
      case "_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F":
      case "_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D":
      case "_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3":
      case "_encstr_B86B0F0F88EB3F6A91A01141914B12E24B":
      case "_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085":
      case "_encstr_81791663D09B96EF69094C498891AFDD1D11FAEB906B4E23":
      case "_encstr_84C710D3602B067FF9F9BCB918AD378F5B60":
      case "_encstr_87DF113707958D5AC21B8E5EBEA1EA733A5693":
      case "_encstr_8A0110D3EB5567B4F8217471AF50BDE38DC0":
      case "_encstr_A38D13A343A04392178DFBD0271ADDADFF5E548753":
      case "_encstr_ADC50F138148BECFDFF83B1366AD2735E0":
      case "_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD":
      case "_encstr_81FE1A3F1B8A6EA889F57BD2D171389EC1F79385DF71ADA0B20F418B":
      case "_encstr_845212B79302E610017DE35AA9FB1028EB6B033D":
      case "_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728":
      case "_encstr_82EB149367A51F026879C5F83F716BB011D3E36A8280":
      case "_encstr_B453120ADBF8B35A77196B571726D3ED70E04354":
      case "_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953":
      case "_encstr_BA9516DC07CA1B2DB08D1D97AF23B2B6DE63A5A3D2EDDC9B":
      case "_encstr_AF911B1780B7F053671A5BE231079C908CE9A5A1075AA0A8D36251698B":
      case "_encstr_960412DC1CB26C96B0C68E5EFA6EAE3807B79C3A":
      case "_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19":
      case "_encstr_A6B5137F3019DB2A03F1D388700FA372C350F387D8":
      case "_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD":
      case "_encstr_BEF4111A80D95E49B0A1D040E6103721326D73":
      case "_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F":
      case "_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6":
      case "_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7":
      case "_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8":
      case "_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939":
      case "_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F":
      case "_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA":
        break;
      default:
        var_0 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
        break;
    }
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.perks = [];
    var_0.perksblocked = [];
    var_0.weaponlist = [];
  }
}

initperkdvars() {
  level.graceperiodgrenademod = 0.08;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.regenfasterhealthmod = scripts\mp\utility\dvars::getintproperty("_encstr_BE37130E2B27B5FACC58B9479256ECACDC922CD1B2", 2);
  level.explosivedamagemod = scripts\mp\utility\dvars::getintproperty("_encstr_973C1578B54BAF293330EB22A0379C6301BDF1EDDFB1DF", 40) / 100;
  level.blastshieldmod = scripts\mp\utility\dvars::getintproperty("_encstr_8AC5162B7F5A7080128B83AF83695338E59511C766B18045", 65) / 100;
  level.completed_areas = getdvarint("_encstr_8CFC18C07B206CC78E48DAE3534E53A420C14C6B8F507517B6E7", 55) / 100;
  level.blastshieldclamp = scripts\mp\utility\dvars::getintproperty("_encstr_82A618A87AB2E7DEB32CF7F62C2F60ABDF5280A9028E33F33378", 80);
  level.completecollectionquest = getdvarint("_encstr_93BA1A4BE176FF8148B909039119943F153882E06847BF0271E9222A", 200);
  level.riotshieldmod = scripts\mp\utility\dvars::getintproperty("_encstr_A942101BABD34AE9C8E8B7D3F7A84BD75010", 100) / 100;
  level.armorvestbulletdelta = scripts\mp\utility\dvars::getintproperty("_encstr_8FD60F6AC0FBB311A143DD809887357E64", 1);
  level.minspeed = scripts\mp\utility\dvars::getintproperty("_encstr_8E4219C1ACE4DAAFEC07CDA6166B5BCA93D7DA5ACDF5B9C1CACA32", 100);
  level.mindistance = scripts\mp\utility\dvars::getintproperty("_encstr_B25D1C38394B2241FF10973A5F1DF0CFF549B5F810D181044B6BD1C6AEF7", 10);
  level.timeperiod = scripts\mp\utility\dvars::getintproperty("_encstr_88381B13F9D0481657633022EBEA788780B1DCE78B8A07AB799D53B878", 200) / 1000;
  level.minspeedsq = level.minspeed * level.minspeed;
  level.mindistancesq = level.mindistance * level.mindistance;

  if(isDefined(level.hardcoremode) && level.hardcoremode) {
    level.blastshieldmod = scripts\mp\utility\dvars::getintproperty("_encstr_8E64193BA8D3B2F08312FFABE303F2B383E49CFE663889A5876B6E", 20) / 100;
    level.blastshieldclamp = scripts\mp\utility\dvars::getintproperty("_encstr_8BFC1B63C95EC7B960A1E1FB7901BC170D409AD870BF972A09C127D82F", 20);
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    level.blastshieldmod = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA940F98C6C29B8EA90D5A563623A6B7C8", 65, 0, 100) / 100;
    level.blastshieldclamp = scripts\mp\utility\dvars::dvarintvalue("_encstr_ABC211C4C6859B1DD4D0B4B28DC80D1B166B07", 80, 0, 100);
  }
}

giveperks(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);

  foreach(var_3 in var_0) {
    if(var_1)
      var_3 = validateperk(var_3);

    if(var_3 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
      scripts\mp\class::loadout_giveperk(var_3);
  }
}

_setperk(var_0) {
  if(!isDefined(self.perks))
    self.perks = [];

  if(!isDefined(self.perks[var_0]))
    self.perks[var_0] = 1;
  else
    self.perks[var_0]++;

  if(self.perks[var_0] == 1 && !isDefined(self.perksblocked[var_0]))
    _setperkinternal(var_0);
}

_setperkinternal(var_0) {
  var_1 = level.perksetfuncs[var_0];

  if(isDefined(var_1))
    self thread[[var_1]]();

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_setextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _setperk(var_2);
      _setextraperks(var_2);
    }
  }
}

_unsetextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _unsetperk(var_2);
      _unsetextraperks(var_2);
    }
  }
}

_unsetperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    return;
  }
  self.perks[var_0]--;

  if(self.perks[var_0] == 0) {
    if(!isDefined(self.perksblocked[var_0]))
      _unsetperkinternal(var_0);

    self.perks[var_0] = undefined;
  }
}

_unsetperkinternal(var_0) {
  if(isDefined(level.perkunsetfuncs[var_0]))
    self thread[[level.perkunsetfuncs[var_0]]]();

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_clearperks() {
  if(isDefined(self.perks)) {
    foreach(var_2, var_1 in self.perks) {
      if(isDefined(level.perkunsetfuncs[var_2]))
        self[[level.perkunsetfuncs[var_2]]]();
    }
  }

  self.perks = [];
  self.perksblocked = [];
  self clearperks();
}

removeinvalidperks(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(validateperk(var_3) != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

giveperksafterspawn() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  self endon("_encstr_958B16B1DBC232DBD51DBE0E2B39ADCD7D1B1B5916275619");
  scripts\mp\class::loadout_giveperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
  scripts\mp\class::loadout_giveperk("_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693");
  scripts\mp\class::loadout_giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  scripts\mp\class::loadout_giveperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D");

  if(self.avoidkillstreakonspawntimer > 0) {
    var_0 = self.avoidkillstreakonspawntimer;

    if(istrue(self.inspawncamera))
      var_0 = var_0 + scripts\mp\spawncamera::room_door_windows();

    wait(var_0);
  }

  if(scripts\mp\utility\killstreak::isplayerkillstreak(self) && isDefined(self.playerproxyagent) && isalive(self.playerproxyagent))
    return;
  else {
    scripts\mp\class::loadout_removeperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
    scripts\mp\class::loadout_removeperk("_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693");
    scripts\mp\class::loadout_removeperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
    scripts\mp\class::loadout_removeperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D");
    self notify("_encstr_939B1482339AFF05D9613947D0D1CCCA972BF56DB222");
  }
}

updateactiveperks(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = scripts\mp\utility\weapon::isthrowingknife(var_5);
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_8C8D08671D451291C849";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11 && (var_8 || var_10)) {
    var_1.waittoopenaltbunker = gettime();
    thread scripts\mp\perks\weaponpassives::updateweaponpassivesonkill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_A7EC17BF91DD5A0168D04B10AE9842B2A4C76F230977B3D040"))
      var_1 thread scripts\mp\perks\perkfunctions::settriggerhappyinternal();

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072"))
      var_2 thread scripts\mp\perks\perkfunctions::setboominternal(var_1);

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_8E621237838FB6EB8F12ABEA513422A381ED81E5"))
      var_1.deadeyekillcount++;

    var_12 = var_1.pers["_encstr_826A126196C148B178A0F797C7738EA221B9A2EF"];

    if(isDefined(var_12) && var_12)
      var_1 notify("_encstr_AA0114D053B158038B989C0772E33D21E3D368C0DF55");

    var_13 = var_1.pers["_encstr_87990ABBF3EA49C8FCD07C50"];

    if(isDefined(var_13) && var_13)
      var_1 notify("_encstr_9AE71120A341A8F35B48AD3BE3D32B57B97798");

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_960624285042C66A89B22B335F0BCBDBE5E6494E939B283D38A9B20BB5882993A23B9309FA71"))
      var_1 scripts\mp\perks\perkfunctions::supersprintkillrefresh_onkill();

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1"))
      var_1 scripts\mp\perks\perkfunctions::regendelayreduce_onkill();
  }
}

setomnvarsforperklist(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(level.perktable[var_4])) {
      continue;
    }
    var_5 = getperkslot(var_4);

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_2[var_5]))
      var_2[var_5] = [];

    var_2[var_5][var_2[var_5].size] = level.perktable[var_4].id;
  }

  var_7 = [];

  for(var_5 = 1; var_5 < 4; var_5++) {
    if(isDefined(var_2[var_5])) {
      foreach(var_4 in var_2[var_5])
      var_7[var_7.size] = var_4;
    }
  }

  for(var_10 = 0; var_10 < 6; var_10++) {
    var_11 = var_7[var_10];

    if(!isDefined(var_11))
      var_11 = -1;

    self setclientomnvar(var_0 + var_10, var_11);
  }
}

isperkinloadout(var_0) {
  var_1 = self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"];

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

getperkid(var_0) {
  if(!isDefined(var_0) || !isDefined(level.perktable[var_0]))
    return 0;

  return level.perktable[var_0].id;
}