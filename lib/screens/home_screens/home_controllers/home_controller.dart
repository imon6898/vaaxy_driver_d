import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaaxy_driver/methods/map_theme_methods.dart';
import '../../../Repository/home_repo.dart';
import '../../../core/utils/cache/cache_manager.dart';
import '../../../global/global_var.dart';
import '../../../model/address_model.dart';
import '../../../model/direction_details.dart';
import '../../../model/online_nearby_drivers.dart';
import '../../../photo-base-64.dart';
import '../../../services/network/http_requests.dart';
import '../../my_account/controller/my_account_controller.dart';

class HomeController extends GetxController {
  RxBool isRideCardVisible = false.obs;
  RxBool isDialogShown = false.obs;
  var isSidebarOpen = false.obs;
  String stateOfApp = "normal";
  List<LatLng> polylineCoOrdinates = [];
  RxSet<Polyline> polylineSet = RxSet<Polyline>();
  Map<MarkerId, Marker> markerSet = {};
  // RxSet<Marker> markerSet = RxSet<Marker>();
  RxSet<Circle> circleSet = RxSet<Circle>();
  RxString humanReadableAddress = RxString('');
  GoogleMapController? controllerGoogleMap;
  MapThemeMethods mapThemeMethods = MapThemeMethods();
  Rx<Position?> positionOfUser = Rx<Position?>(null);
  Rx<MapType> currentMapType = MapType.normal.obs;
  List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  bool nearbyOnlineDriversKeysLoaded = false;
  var isDriverOnline = false.obs;
  var accountStatus = 'approved'.obs;
  Rx<DirectionDetails?> directionDetails = Rx<DirectionDetails?> (null);
  Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);
  LatLng? meetingDestinationLatLng;
  LatLng? shootingDestinationLatLng;
  Rx<AddressModel?> shootingLocation = Rx<AddressModel?> (null);
  Rx<AddressModel?> meetingLocation = Rx<AddressModel?> (null);
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();


  // Simulating ride data
  Map rideData = {
    "riderId": "123",
    "riderName": "John Doe",
    "phoneNumber": "+123456789",
    "gender": "Male",
    "from": "123 Main St, City A",
    "to": "456 Elm St, City B",
    "picture": "",
  "pictureBase64": "iVBORw0KGgoAAAANSUhEUgAAAKkAAADOCAMAAABy+tL/AAABYlBMVEX/////xz3m5uba2er8AGkAAADIAFv0fIH9XGf/xzr8/Pz5+fn/yDbp6enz8/Pu7u6srKyysrLIyMj/yz7e3t67u7vT09P/AGWeAUjJAFjCwsKfn59YGDn6xkH/0D/0eYOvsri0vbr/ySv81nfl5e3MuZLTu4fxxFPIuJZDQ0NZWVnJAFOdAEHZvX31xUzuw1nEt530iXl+fn7++vBsbGyueo7jwG2+taLowWTdvnZOTk4uLi6JiYk5OTn74KP85bK3p63wMXX7u0i4tKr+UGj5ZnH1j2L7c2P7n1W/mjJoVR/huTuhgSwcFQvarDojIyP9789+ZSPpSH7Mg5vgWoiaj5RRAC2/Vn32h2XyqmD5sU/4a2j6l1n2kHP2pGb1mmZSQRiWdi5BMxYkHglnWT382ozYz77WapC9nKrEkKLVeZV1UGG6bonDLmephZGMeIFlPE5IAB6lS2egLVXGRnGgWXFP74esAAAcPElEQVR4nL2diXfTSNLAY5MEdHfLkgIyCpIT2znwsXHwASFxMDCEhMQkYZhlZnY5Nh8OxzA7zP7/X7VuyZIsW5mpt+/tAHLr5+qq6qq+PDcXLzQnYVXKM3TCMxmFFvKKrEpMtlYYBaMBRrqsCBlbihGal1QdkXfI+UwNSfqg1m7XygNdV7K1FC28ouq4Wel12xWMs+iCkXGbZVlKq9Y6OhaFKyO0m5dkHZW79RwF7yjrYgYTk/SyRuVyOYqitN4AWPmrw4TWZV1vVnMseUOOrWI1g1Il1DabIbAltoZ1LF2Za3Eqws1GibXbz7FNnZu9NXXQcFuCLmqUB0gRroSVkbDeaVNe67lSRVdmbw91qr62cmyu3dSxcgVRIC+iQaXKUv7G27oyuxJQ0zTTwvLyMmuptV7T9cyeRROFdimLk7XbZhu6OLsO0BohpbRffvjpUYGyWLvgWXEBi2F4XhIt4XmeiX4zr2K9olmdxWr//OGHN6bX1rOQFsumSp/duPH48U+PcpaTamWMxtoEREUUMQqJKOZ5PtSneRhMuiXre2vPnjy+8fjngvnfGUgFVCbfvPD08Q1gvfGLVrDU2h7ogRGFlyCA6zoadJpr5UqlVuv1apVKudzswPAGhi1xXnRjFITLdcuWCm9+IC3fePyI/FnT5ZmDoGKSUrmnT548IS3+9KZgdVljTZedeMXAqA2UnXKt3a3WNRLFLclp9Wq3XVsbAK3qhAxB1Ac9zVHoz6TVJ0/uvLFJZ3YAm/TRr3euX78DrI9/flOwLYA4FnmEI5h6s9ata4SOojx3hv8mf6VV25WOrssq8ey8rA8a1jMF7SfCeeM6tP2v5Ssi/cd1IkStj5/6HEvmOfAN3AEdBRCDQhEho7GOFAnpZcvac4U3lkJJy3f+nVWn+QDpddOkfsjZTlvvQA6EB5UGW4qD9AXLEtWFYQPyHSuGUn7Q63eeLme0U/B9P6mN+sg2Vq2CmzWtxCYRBmCr5WbXAX1247Hd9Q5pxii1Bg0XXFLTrW5Y4Y94WrfOTlanjzVXz2nWJ38xW7JVCr1/BaTgpp5Or1vt//zG7CwtNxWnhUhQC4WnVkM37tik/yJdV808RvlIn9hveLZsKWcW0bRHP90IqNTy/YyjabMeIP3ZfsXjN7Ny5lyvD5CCTtlullQacinKjqcB0qcza9REdZTqkYKTlnqZsj4I0zCWuKRPLO+34//sqJrl+i7pP9ms+SkedFlwg3/7SR8/fZSNM2eN+H5SMpqyZV2anVQKkRLQZ4VCVlAQ9tEPPt8nIZpdy0KqmHVU4V93XJVChMqsUVMK2lMvnpJeYjuxaW8anaIeacMmvUOi/lUo1EJd/sUZo66TCJMbZBhMgbRikjoqvUJQEPaZo1QStbVMVXReL4ObF97YoD8/SjvIpxIqZ6P+g81c7+d1Mkixb/5h9v0Vg4IsPzPT01+XzcCfhZSRO2BCVory5OpBiQE8sRMUNlPgB9IBGaQ0IL3z85XaqCOlX5whqpIlSM0xKiaDVO5X0OmzMGihsLw8zWBlPh9uhIIQaA1RZT3LZCKtoC4JqP++fv2foXcsLx8eHxwcL6cNr4Xl+gE8ry2H2iFjNQxRFNXMEk5JfVIzScGUAkQF7eDtApEPR1oqoygcW88vPD8MPc8++vURsbABygIKzm8F1H/k/KCF3PHzBUeep0EtHLjPL7wLsbKPNDNI4YykZdLWm0f+xguFgxfei98fpyBdPvI+sPA89AmKkHYzkgpyh6SiWhD06IX/vdPqNOLLaTmqh9VMpLw6gICqhd7qB31xkM5OXwZQw5/R2ArKEqQgTIl6lQ2S2qAvPrx9/vLl83fachpQ4lIvyfNvP5iob0Of0rQyyjbXSSt6mw2qVANnevH25cEhxEfyv3SgYKrm89rh0fP3gBrqCareRBnXECS9Ugp9/fcLz48Ol9MjBgVwj4/eLrwL+X+9k5U0rzfDo/0xUedsmDZs7vDgMPyXFSRmAoXeXyuFX5S9PBlvgqoPcCZDFWRcvfoMKkpKNT2LUkGllaspmyYKDKezT0qaWV/jbyLNsbUscyh5ezXy7xCqjjMolSzw/k2g2aYmBHvl7O8RqjF7zSei2t+nUvCptVnXeHmoov5GUlL0zRioJH3t7+t7QtoY4Nm8X9ST/Yks/E4xXE18HLp/toSKl/UEf4K06Pjo6CBcFcULefzoMDHtZmtopnQ6r3fCQ77/xQfvI6uiuO9lV4jPkxJvtoHlWUglvRZPeujm8G9T1VHvnDrhw1H845TWmSVNoUW9G2ummq/YeDuWwY1JwVfwJZUzs01PWCVUjIq8N2+fLLycpNRlsJT1+ymK2dniFKevxaro0AVV5qT1cKkx9jgUNDtzczvOZ17GOipb1dXp41Q+PuHzVLoFDxbH6rcw6cGHBSg94CtNUiqVmyVLkfRenJlqbx1SElSUhwvJ/g9Wug3P0dvOpw5iHy11pjfUBIcqHH6wX/mATHnm7y8cJSmVdH5xzlS+2/2xpDMsoFgTkpGy7E5NPCTNChvJPlU4fB8ifR8bLaBGmYGUTPJGk7pm+pDolLu/8DxpdbJw/CJE+iLWWtj29Ik/r3figpRHekJiCnjK86Q0ljq2PM9z/oVYnbLd6TeiCXpzMukCmfNUHySTEp0+IN99w9NpLOkMS+dJpGTi7qEZydfB9UBVL0NaDG6fIQ4IZiKfEB/cMO00NkzVdXXauRRGXotTFFHSiy1kqmiLRwDg+T7ZeURpZD+Ft6Hi8C3xPYk8f7KD7if5/iyk1lJUtEA8PdkpFk9cI3BDOZVr7A5bRIYXVWceu/DOG3uLRQCOT1KgQHVJ6Wgz4PKitxtPkWjwqHjSZXj1lvlOSz7YkzcUu7LXWlVkhLAq8a29FUuv3oTrCXzqftLAD6TiHCephGJnx9wZmPfrmJG3tjc2iq5sbewUMYonJeM+PL7lkNqdT2m7Lb64cXKyvr5+cn9LpVu75laqwqGzKvBgp7hzktD5heXqzs7Oxsb6joMCf9gueiF2fX1HlHyjGCehnYWT/xwsxw09oFSwOGd0fG8l8qy2R88RengBgv9/AEPt0Ny86Q4V8KGNhQ9xCU1hWTt6u/Bgi5wfcFDovAQacZcAovbqCzsPX7w/jikmCsRS7zt2ar2ZrQ+hYWIR69vbGw8IMUTGoRlA3Lnzh+uxVloo1I8+vPhPcTye0nyikzFqs/vyw/MY1oK3zPPeAqW0IfmY6DrPwrbZSyZqYdl9/MXLmLU27ejD+6PDxvSRn4z7y8fvPoSXZBzUw5dWjz4/XvaBztH4oQNqW9fQ3BZcOLLKrrcxGoWy7P2RtjzLBh+G5FJQfz5/H+1YpDR9+fLowN49S+05H1R2oIdPNpA7HTIk1RhVOD549/JdXC0LKewRmekuzTA3Za5FmMuOcSEF6mjNXpGg2AuvzxhIAwOF227JeVyLnc4+PDb/qdScoZCCnD/1VI8fFL7k+kKgGG6tpG2IKsyS8+f1ZtqdZlSjNcdIroNKCws7TjSh86CjVtrpYlJHTQ06J8ixCWoYlAJvUqwclEgRzNSxUmmdJHzDlJObs22cgPKknWK3LkiJeBP/cMNWKv3wftHtftmK2rup+p+F4mSWRX4JDy7S7CwuXdiaRI5KkbBxYimVu79u/UdjMipbqu8O8CzrZ4KM5lq72qTtsOxKy3p+Y6HIz9HCDilExQcPJZqmpYcntt3R9WRUSBa7w7n8DAvSAsfxMkkNWnvVxL27VH1of4TbhlwJcgFSMc+p6wv3t+4vPHRH7ERTZdnqxRBGTbWowIvTDlI0LSIMyRUM3uvbRVmiIXujYhVCaW7In+PR1sbGlmy5vVTc3tje8YXxvVitstTK7lAQ8c4WvBGkiNOcFxKAcX2raB1yAdz769si6HWlFK1XqrTn/zST9ymEzwdD417kln/odkhqebQBeeLWtvninS34xhOWUfmdh+tI4pwzOAoSOWmLdGBruEJFOFcIdIIM2bBWKbakXQzBzoViURLAMUx/YhieE7cfbMcHLB49WA8GCYS9xYzWbj14WgPiqDYNKKBWWffz5KwHpYE6vX9WkD+PEooL9/ORJsvI9zfC/5APHi/a212p50omr3mi5KI1N6Xsrmjw0ZJ53HJldy/wed6vF4v1YaRetzbksW/AyDiY2rSGe7sXKyvV6srKxe4w/HgKIQ0Q2RsOw19TRGOpaX5nfXxKhS5GjQ4Skse8kBSepP6cgTNJ8ihqp6wcMRREmgRErGxbGVILL+PIBb7UJ7I5ebxP/gph1MwqyWMkrnJ/5VlzcgiQE/EM0+YhAVO9du3a6ir/Fx02Z4TV1WtiKIPmGWYG5Ygm6l8CSxNKEBH7tnQyeUVRQURFmpIWTAhfswVor4ySsSgtUDcY8gouIjRoNjtY13U1P5VyGBGhaz7hhFm6xs/I8Hlfe6oHykgIixINpVepRGndygBNd2acgS8tXgsIKJdn6Gl5CSPPrQab8oHyKhatWLVLmVlBvddE6jQ1IK1grF4bk9XVVYGcKZ4MTNM8zwvC6upYG4qKZAc0j10NWrNEAEvuDZjGBOg85KzKOKvNa4pAHNanZ/Inhnf+NfqzYKLIPRCex7IX/J3Km6Iaa9PNqENcDVtAnNhkcXB+UTFyd8nQyB+pvBqR1cpTVqwKsMaodVaBFj244HA6LPmy2NqUAxgnR1rrzCLDN/eCXh4FFEf79hZQWmXKbR88Uat4NXoVZbBQf6asBnbLMHMF35lbVmvq0wXyvD4Y6FhNaa/JnBgFJpgF7KmUkURVXas1vGqGrU83ryrog0a9jHWcUbGqrOsDjAKvznvTmAyYBWgcDcpeOVuqTDO7QiPcLUGNVoO3YHlmTPgwXuuyjeClMgpy/sTbI4Gg6HrPLYm1zhShSkH/t7uyogFre20Ao7I8vRWIRJvNCvQrxQa2xtKiy6243sOrqOdMaFA9PbVT5Unog8pk76Jeohq9MkkhZFVMZwiKIpI+J5f0dOum/VFU0zf/DKSOMSjeARReNA8SmqSNQdrZakipbEtqkZmKUo7cdUDyHSybvEoMMWFUZUKpD8q9Rp1yOpTsjvIcWnF1KhW9v+Xljj33SmnltLm25I93dGtXK0EpXO9WmpjggpeBmMyuAB8m/2D+M1BWNSowX8D6tx3k3V3yvOyzirxecx6vpZwHFORQkU2b04BsqaRVu7VyszMYEFZkgplXdlgyGDTLtXYDrHvsTgKq3vRsj3MTKlr1kUIaZy+Js91BKu+HInXMTIYXmmVwQFFitWqj2ya3i9hSq9V67W5DK5B/jJ7VYtveLCTt/meAFJRqb4dhq51UhspH7rcdevtTKft2EcoR1vlzFKMzSvo2R4pOCuAfA4h7lEv2w81Uk6tK9FGbVrattKBUV388sqZLoPcCq89qx8n/1tJsT+RRzAYBJsW0eJJSm56bQBTkGIZTgzphxIG9hMOW9RSkEorLELNplezl8V4imz4Y7DxCahlQKRUpjj9dnXYFJ1qpLPZNfEFmIkqhF/lIKylIhYRMtnWRitRxuNBfT9zH6ZGm6n0FJTQ3jN38aYk5X8pqjXav167mQrBkg9QkUmdMK08+kwgDacJAlrgsSrG5aq+y1oS81pTBWjvE2kzezMOoTdf3J0epPE4sY+IX8ECTFQtRlk136fcBtue/mgaG1MTu5+WKG08nF1NS8rnFvZjep3LdNQy5oZTnSLWfl0Tc/3h+1tc7bc0bMSbsj5OcrfowRk0cTRkRJSaxw2hScgWRLkq+rJKWcP986fRMx142T9WTU2RFt92ASjHu8+r4CkCANHJ7AVttorHZj7yMz5fmT0dGp8262VxSisyIHTvwU73JuZQgJ++0jNQp6Cpq6iOP0enS0vwnA/ecjKCGEs7FgJk6rVfGlxzCMsFM5/YiPIrSOtHhBwxgf2l+6byvV+y76tpJIVAadCnnm0+uTieRXkSQspW4ySQFf5qfn186HekVM6SzjUF89KHFppueJn0hhzR6VcNtLSKestXYS80YuX9KUPdHhqlVYiaxbQvuCS2qNnlugpGTr1SJGqPYhFsj8vhs3kTtGxXzIpRmPKnoXsEJ0XSimTITDq3t5cZIQU/xJ50Y0Ti1UfUauRZoLZaUR2Xn9skunpzxMzjx20QNptBuwniSN86WHNReiWLLsc6vuudyS4mxzBZ+/BZJv0Qt27M9K5+NuwET7Zuo86d9vcGylThSzt2yRWk4xRRqMmlkfsLWiKMKSpz7G+cW6dJHvVMvxZHyqpPwke1JKQ4jOgVOtAyj0hOiJprc3BntipxxaZHOz58Z5VJM6Ge803kQndNUe3ziymlkHUUmkTGS4xZoaBnPO9LH7RhSybzhxGkvTQWdqNNh5LE0tocTd72I+NRW6tK5vhbZ+4yEKu7sWbWT6mKPRNLoLJqcx0waURT80el+6P9BBCkv6h4oFetzQUmKp63xWGrblR6vUXr1mhX8TaWeYjzOIageKJnnSTchnUQalZyYjSfteF29dg1fuoY6f2mM1T6Srte8uqDQSTl1mjCatuLmJcgNXDFq4MlUJR7tu0o9D98uIyDUrHv2n/4MOq3EHq2Mr/VZa3MuI0jBAMBw5qSq3N93XGr+U4CU4UTUqXntkrnr1DdYK7H2nFDrmZeFCRCr/LP5zKo9h44d0qX9M8MjpTlFRZ2KryKkqPYUq2ax+Wli/bymS5KMZMXtD5q31ydVKFNtUkhTjVHfKjv4vKLqqNyuB2aD24MpViIEHON6SXMSEKh0jLxfMqAFm1PEBvpctEgh9TcuF79gmZNEEWrtTq0R3EXK9gbT3D7AyzHeEVc+29rAdl/QtLemL8KQ8O32f21SMNGPm4ubZwbZJVHpaqXg3kGWqky3YBZXRbeiyhJXqFwNy3mG4QVvUZosQb76/cfbPxLSpf1LY/R6c3Hx1q2RAWV1eNKKYqvl9M5kiRK9vtpKnpAC1IHurQGRZR7g/Hz7x9u3f0QQpcBEjS8ACqhf+4N2uC1W63X0aX8OIGb2tJVwaN5SSreDsLWcosogr779TjhB0Gj+Yx//1u9/vWWivtZDF0WwpUYZyVNfO8GH100s2ZtASqqUsg6ohBIXv32+bXPevo1HZ9jAX74YI1Opi7e+6ANvBihHleoVPG3PE2HEyEQz0Uxt1dT0z5+/ffv2+ffb//2vg3n79u8Yg4kar27+Zry2+n/xnnvpEgQpwjnVRhlXors/xSENticXXwHo599//x0If7Tlm4HvLW6O8B/fEbb7f3Gk14AR3KreLWNdnPHyPh5HdH8rxREKCFUYQ6A3DFR89QqYiXo/f8P4C3j8a+PezXsQT2/ZXmVAil9tV5pYVqI386YRJSLdbGkpdNrGZ6fn5x8/nV3CUGQQQQjh/utNwPuK+9/v9vHrW5ap/ml0KuUO0kUuyz43LiKbHqY4P0H1nOKOyP7p6fmnM0D+0zLOe8b/7v4h2/6/uPkF1C8KWbdlquMzPtGFSdhOdR/p/JIpHw1LjZt/Gr/dvHvPuLdoy700pfIkyY+XfZODFJlN8uvUSUjdgD/C3+9+9/r/628ZL+0jwowrdTcFaa5izewESE/7lzbaF+j+u3+g/qKD2jey//bP+KpEqpNkFX2cdH+EF20nQv27N8H/z6z4v7j52shyxZglEP1DSk1DWijr+2FSUo7aTrQ4Mm7evQtB9dxB/WJk+cUjS3g5NH23Mrn3yST+OClxqU1bh/jV3Zs+/1/cvAqvUkIDFdEpxUaX0S7pWj+C9Bzf23QMs//95s27vxlfbPcnXpbZqxg5GP5XWOBsV5JOE1L15iiCdL/ft3sbQuoXUOr3PvrzlmO7/eQp8DQiBBf5V0psu4kT76CKJiWTUa63GyPwqbv/M0ZOUL31OvKwxHSiBOYnV3JlqHy6iXZa71xGkC6dYUeFm330B6C6SZUVu7Lcge2g+ky1ouv+39SKJK12zsZBSew/c0i/yPeIUr/3ja8O6ubIyOxVguzbJU5+YGdCoKIag0jSU8igbLF86uZN6P9bjql+HRmZvYqX7VUhRtE7jYm/IkI1jCjS+Xk8WnSw7sn/I91/d2RnA7ZXZR4AJGQGAFrUmxPOZZqkXeNTFOjSCDkBFLLU34hO737H/T89pcbue5kGldRhir6WIjvNsV3jYyTpJ+wq8OsryFJvmv7vJNWLo+TlmrSoGEkSWkuhUdBpG0eSzu8bXxzSRZKmmFodWfik/L8KUHOzkN5Jt/eI7cWSXrqGaqUpQPpHn9gEFH9XBErSqoS73EKkejTpfN8d6RcXLw2z+0lSdQlVy1mmHz8IiKSX06SmObOIHkukLbl0h0+SP92zlPr9lfHnrS8RRwdnlKRL58KkFf08WqefjNfu8Pm1jyD3I/IH7t+7Oo2SGwdT/7pVpX++FKnUc59LbV4ao3uWQP069Q1DscKondQ/cMU29cvz/SjWfeymJKR+tgpsw5Cv8uc+Bfx/u1UqHStFkq3R2en8GOv+yOdSt/qyxNlyhb9LKsIg1RpesKl+4IzSupBwocuP82HFQjrlKhV8KntNOi72MSFyJ1MKxVIk2+5gA4cU61Uo5jiVuIg8ozDeUsZwpZ60t9iVEtslrKOPvlR16dSpUMzuvzQy5/ljEtiGTPZ0p9Cr1htgRTSM/pnrXqRC8ewUKr+rPyksBoopGgx2kr2y1TVIwGhGkFSjP/pks+5fYsdKb/15Nrq6cO+iqaGpg9awmjiTRpUaA+d4I5MXDdy/PDfdyy76N2+9vkTYf6TrioTBY1++tZuLVyubqwV+D5dRZAxWcErm0T5uQpb/qW+QGb6r7HuaJkcdpaiV22EjxrMottvUvXUFWiI2zomyYVyen+PLxdeX2JBVJc/liZgnbrMh0wzP85zZnBS5vYhc8BKlUI2s83jWwtgRjlcgFPRx/zfgJLtT855wgjD2I7OpheEFty0umhQ8azxhBQslP9jqMxbauYxPRKIoI2SoisT5OW0RhLif8E0QWgg0xSlx00atlZBjgYU6rsSL9rKk7Y4cxtA7ihJUZ0A4brqffGfCLRGd0tB7Ef1DX/hDK8VWm7pTcuedryeZlS2vIoUjMLGc9stST6SPcZqkMs3I0Qv+3gY/iq1XyLmjfIiUI4bKQN9PYHQlnV75yM/KsiDF7A2g97xj1x1dVhQZKXZv2x8ASEkQsRzf62FJE2YjNEqUqmLFf/NHsKUhMQCWJVvOiU87OxF42TmFw8sY/k5Ky5lOqzGkEsK+kT+8nWJYYkvVJrZhuDw59AuBSEU8TZPxlHi8OAVnuv6P7n3wW+90uILCK2pDiEzQ8U73Aqt1QMc860rOzqlS6p43G0jlVHxUm5zoTk2C1YWSABjY/Zzm85yk2IvmsijCP00FmnaUZYSoZt27XJTgzC9JlhAiwTz03dxwxE0MTCHOKdIWsK2xz0uyNWuUD2gUMGVyQWs+vV8nC8dPuS5J03wIFmIq2bBJe3eYkG1OGJFbN64Gkmhz1uVT3t9vHEc2bGEsC4LASaY/mx4+XdfGCeQoszF6yoVMRbCzAE4iB/CxdasvJltNpnWVCEJAFFJdBJJOSI4qEGKSYZhniiHRkKb0lHEtmvd+XBGiT2jazKoZhqh4Wn/2VEiUaF9MkjF/TsvNWBefWCJwcQJeYgk8Oyve/wOjbgP0GpvDkQAAAABJRU5ErkJggg==",
  "address": "123 Main St",
    "ridePrice": 50,
    "preferCar": "Sedan",
    "distance": 12.5
  };

  final HomeRepo homeRepo = HomeRepo();

  @override
  void onInit() {
    getCurrentLiveLocationOfUser();
    super.onInit();
  }
  Future<Map<String, double>?> getLatLongFromAddress(String address) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$googleMapKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final location = data['results'][0]['geometry']['location'];
          return {
            'lat': location['lat'],
            'lng': location['lng'],
          };
        } else {
          print('Error: ${data['status']} - ${data['error_message'] ?? 'No details'}');
          return null;
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  void startRide() {
    isRideCardVisible.value = false;
    // Add actual logic to start the ride
  }

  void cancelRide() {
    isRideCardVisible.value = false;
    update();
  }

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
  }

  void toggleMapType() {
    if (currentMapType.value == MapType.normal) {
      currentMapType.value = MapType.hybrid;
      update();
    } else {
      currentMapType.value = MapType.normal;
      update();
    }
  }


  Future<String?> getPlaceIdFromAddress(String address) async {
    final String baseUrl = "https://maps.googleapis.com/maps/api/geocode/json";
    final Uri uri = Uri.parse(
      "$baseUrl?address=${Uri.encodeComponent(address)}&key=$googleMapKey",
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          // Extract the place_id from the first result
          return data['results'][0]['place_id'];
        } else {
          print('Google API Error: ${data['status']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching place_id: $e');
    }

    return null;
  }

  void approveRequest(String riderId) async {
    MyAccountController myAccount = Get.put(MyAccountController());
    await myAccount.getProfileData();
    var body = {
      "riderId": riderId,
      "driverInfoList": [
        {
          "driverId": myAccount.driverId.toString(),
          "userId": myAccount.userId.toString(),
          "driverName": '${myAccount.firstName.toString()} ${myAccount.firstName.toString()}',
          "email": myAccount.email.toString(),
          "phoneNumber": myAccount.phoneNumber.toString(),
          "gender": myAccount.gender.toString(),
          "picture": myAccount.picture.toString(),
          "licenseNumber": myAccount.licenseNumber.toString(),
          "launchhYear": myAccount.launchYear.toString(),
          "color": myAccount.color.toString(),
          "modal": myAccount.modal.toString(),
          "brand": myAccount.brand.toString(),
          "numberPlate": myAccount.numberPlate.toString(),
          "expirationDate": myAccount.expirationDate.toString(),
          "rattingLower": "4.5",
          "rattingUpper": '5',
          "pictureBase64": photoBase64,
        }
      ]
    };

    // var body = {
    //   "riderId": "34",
    //   "driverInfoList": [
    //     {
    //       "driverId": "1031",
    //       "driverName": "Imam",
    //       "userId": "2087",
    //       "email": "amran979@gmail.com",
    //       "phoneNumber": "123-456-7890",
    //       "gender": "Male",
    //       "licenseNumber": "123456789012345",
    //       "numberPlate": "121212",
    //       "expirationDate": "2024-11-30T18:00:00.000Z",
    //       "brand": "Car",
    //       "color": "Black",
    //       "launchhYear": "2018",
    //       "modal": "BMW R8",
    //       "rattingLower": "4.5",
    //       "rattingUpper": "5",
    //       "picture": "images.png",
    //       "pictureBase64":
    //           "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"
    //     }
    //   ]
    // };
    print('approve payload: $body');
    var result = await HttpRequests.post("/v1/driver-approve",
      body: jsonEncode(body),
    );
    print('accept result Result: $result');
    if(result != null) {
      String? placeId = await getPlaceIdFromAddress(rideData['from']);
      await fetchPlaceDetails(placeId!);

      // Retrieve direction details (distance and time) from Google Directions API
      await retrieveDirectionDetails();

      //draw route from pickup to dropOffDestination
      PolylinePoints pointsPolyline = PolylinePoints();
      List<PointLatLng> decodedPolylins = pointsPolyline.decodePolyline(directionDetails.value!.encodedPoints!);

      polylineCoOrdinates.clear();
      polylineCoOrdinates.assignAll(decodedPolylins.map((PointLatLng e) => LatLng(e.latitude, e.longitude)).toList());

      polylineSet.clear();
      polylineSet.add(Polyline(
        polylineId: const PolylineId("polylineID"),
        color: Colors.pink,
        points: polylineCoOrdinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      ));

      controllerGoogleMap!.animateCamera(CameraUpdate.newLatLngBounds(getBoundLatLng(), 14));

      markerSet.clear();
      markerSet.addAll(
          {
            const MarkerId("pickUpPointMarkerID"): Marker(
              markerId: const MarkerId("pickUpPointMarkerID"),
              position: meetingDestinationLatLng!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(title: meetingLocation.value!.placeName, snippet: "Meeting Location"),
            ),
            const MarkerId("dropOffDestinationPointMarkerID") : Marker(
              markerId: const MarkerId("dropOffDestinationPointMarkerID"),
              position: shootingDestinationLatLng!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
              infoWindow: InfoWindow(title: shootingLocation.value!.placeName,
                  snippet: "Destination Location"),
            )
          }
      );
      // markerSet.add(Marker(
      //   markerId: const MarkerId("pickUpPointMarkerID"),
      //   position: meetingDestinationLatLng!,
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      //   infoWindow: InfoWindow(title: meetingLocation.value!.placeName, snippet: "Meeting Location"),
      // ));
      // markerSet.add(Marker(
      //   markerId: const MarkerId("dropOffDestinationPointMarkerID"),
      //   position: shootingDestinationLatLng!,
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      //   infoWindow: InfoWindow(title: shootingLocation.value!.placeName, snippet: "Destination Location"),
      // ));

      print("distance: ${directionDetails.value!.distanceValue!} ${directionDetails.value!.distanceValue! / 3}");

      circleSet.clear();
      circleSet.add(Circle(
        circleId: const CircleId('pickupCircleID'),
        strokeColor: Colors.blue,
        strokeWidth: 4,
        radius: 14,
        center: meetingDestinationLatLng!,
        fillColor: Colors.orange,
      ));
      circleSet.add(Circle(
        circleId: const CircleId('dropOffDestinationCircleID'),
        strokeColor: Colors.blue,
        strokeWidth: 4,
        radius: 14,
        center: shootingDestinationLatLng!,
        fillColor: Colors.orange,
      ));
      isRideCardVisible(true);
      update();
      Get.back();
    }
  }

  retrieveDirectionDetails() async {
    meetingDestinationLatLng = LatLng(positionOfUser.value!.latitude!, positionOfUser.value!.longitude!);
    shootingDestinationLatLng = LatLng(shootingLocation.value!.latitudePosition!, shootingLocation.value!.longitudePosition!);

    var responseFromDirectionsAPI = await HttpRequests.get("https://maps.googleapis.com/maps/api/directions/json?destination=${shootingDestinationLatLng!.latitude},${shootingDestinationLatLng!.longitude}&origin=${meetingDestinationLatLng!.latitude},${meetingDestinationLatLng!.longitude}&mode=driving&key=$googleMapKey");

    if(responseFromDirectionsAPI == null) {
      return null;
    }

    directionDetails(DirectionDetails(
        distanceText: responseFromDirectionsAPI["routes"][0]["legs"][0]["distance"]["text"],
        distanceValue: responseFromDirectionsAPI["routes"][0]["legs"][0]["distance"]["value"],
        durationText: responseFromDirectionsAPI["routes"][0]["legs"][0]["duration"]["text"],
        durationValue: responseFromDirectionsAPI["routes"][0]["legs"][0]["duration"]["value"],
        encodedPoints: responseFromDirectionsAPI["routes"][0]["overview_polyline"]["points"]
    ));
  }

  LatLngBounds getBoundLatLng() {
    if(meetingDestinationLatLng!.latitude > shootingDestinationLatLng!.latitude && meetingDestinationLatLng!.longitude > shootingDestinationLatLng!.longitude) {
      return LatLngBounds(
        southwest: shootingDestinationLatLng!,
        northeast: meetingDestinationLatLng!,
      );
    } else if(meetingDestinationLatLng!.longitude > shootingDestinationLatLng!.longitude) {
      return LatLngBounds(
        southwest: LatLng(meetingDestinationLatLng!.latitude, shootingDestinationLatLng!.longitude),
        northeast: LatLng(shootingDestinationLatLng!.latitude, meetingDestinationLatLng!.longitude),
      );
    } else if(meetingDestinationLatLng!.latitude > shootingDestinationLatLng!.latitude) {
      return LatLngBounds(
        southwest: LatLng(shootingDestinationLatLng!.latitude, meetingDestinationLatLng!.longitude),
        northeast: LatLng(meetingDestinationLatLng!.latitude, shootingDestinationLatLng!.longitude),
      );
    } else {
      return LatLngBounds(
        southwest: meetingDestinationLatLng!,
        northeast: shootingDestinationLatLng!,
      );
    }
  }

  Future<void> showPopupMenu(BuildContext context) async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          value: 'light_mode',
          child: ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('Light Mode'),
          ),
        ),
        PopupMenuItem(
          value: 'dark_mode',
          child: ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'light_mode') {
        Get.changeTheme(ThemeData.light());
        String lightMapStyle = await mapThemeMethods.getJsonFileFromThemes("assets/json/light_style.json");
        controllerGoogleMap!.setMapStyle(lightMapStyle);
        update();
      } else if (value == 'dark_mode') {
        Get.changeTheme(ThemeData.dark());
        String darkMapStyle = await mapThemeMethods.getJsonFileFromThemes("assets/json/dark_style.json");
        controllerGoogleMap!.setMapStyle(darkMapStyle);
        update();
      }
    });
  }


  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  getCurrentLiveLocationOfUser() async {
    positionOfUser(await _determinePosition());
    // initializeGeoFireListener();
    var responseFromAPI = await HttpRequests.get(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${positionOfUser.value?.latitude},${positionOfUser.value?.longitude}&key=$googleMapKey"
    );
    if(responseFromAPI != null) {
    }
    humanReadableAddress(responseFromAPI["results"][0]["formatted_address"] ?? '');
    LatLng positionofDriverInLatLag = LatLng(positionOfUser.value!.latitude, positionOfUser.value!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: positionofDriverInLatLag, zoom: 15);
    if(controllerGoogleMap!=null)controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    update();
  }

  // initializeGeoFireListener() {
  //   Geofire.initialize("onlineDrivers");
  //   double radius = 22;
  //   Geofire.queryAtLocation(positionOfUser.value!.latitude, positionOfUser.value!.longitude, radius)!.listen((driverEvent) {
  //     if (driverEvent != null) {
  //       switch (driverEvent["callBack"]) {
  //         case Geofire.onKeyEntered:
  //           nearbyOnlineDriversList.add(OnlineNearbyDrivers(
  //               uidDriver: driverEvent["key"],
  //               latDriver: driverEvent["latitude"],
  //               lngDriver: driverEvent["longitude"]
  //           ));
  //           if (nearbyOnlineDriversKeysLoaded == true) {
  //             // if(Get.isRegistered<HireController>()) {
  //             //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
  //             // }
  //           }
  //           break;
  //
  //         case Geofire.onKeyExited:
  //           removeDriverFromList(driverEvent["key"]);
  //           // if(Get.isRegistered<HireController>()) {
  //           //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
  //           // }
  //           break;
  //
  //         case Geofire.onKeyMoved:
  //           updateOnlineNearbyDriversLocation(OnlineNearbyDrivers(
  //               uidDriver: driverEvent["key"],
  //               latDriver: driverEvent["latitude"],
  //               lngDriver: driverEvent["longitude"]
  //           ));
  //           // if(Get.isRegistered<HireController>()){
  //           //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
  //           // }
  //           break;
  //
  //         case Geofire.onGeoQueryReady:
  //           nearbyOnlineDriversKeysLoaded = true;
  //           // if(Get.isRegistered<HireController>()) {
  //           //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
  //           // }
  //           break;
  //       }
  //     }
  //   });
  // }

  Future<String> getJsonFileFromThemes(String mapStylePath) async
  {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  onMapCreated(GoogleMapController controller) {
    controllerGoogleMap = controller;
    getJsonFileFromThemes("themes/night_style.json").then((value)=> controllerGoogleMap!.setMapStyle(value));
    mapController.complete(controllerGoogleMap);
    setCurrentLocationOfUser();
    // updateAvailableNearbyOnlineDriversOnMap();
  }

  setCurrentLocationOfUser() {
    if(controllerGoogleMap != null){
      // controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //   target: LatLng(
      //     mainControl.driverListFromApi.first['latitude'],
      //     mainControl.driverListFromApi.first['longitude'],
      //   ),
      //   zoom: 18,
      // )));

      controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(positionOfUser.value!.latitude, positionOfUser.value!.longitude),
              zoom: 15)));
    }
    meetingLocation(AddressModel(
        placeName: '',
        humanReadableAddress: '',
        longitudePosition: positionOfUser.value!.longitude,
        latitudePosition: positionOfUser.value!.latitude
    ));
  }

  fetchPlaceDetails(String placeID) async {
    var responseFromPlaceDetailsAPI = await HttpRequests.get("https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$googleMapKey");

    if(responseFromPlaceDetailsAPI == null) {
      return;
    }

    if(responseFromPlaceDetailsAPI["status"] == "OK") {
      shootingLocation(AddressModel(
        placeID: responseFromPlaceDetailsAPI["result"]["place_id"],
        placeName: responseFromPlaceDetailsAPI["result"]["name"],
        humanReadableAddress: responseFromPlaceDetailsAPI["result"]["formatted_address"],
        latitudePosition: responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lat"],
        longitudePosition: responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lng"],
      ));
      print("Updated Shooting Location: ${shootingLocation.value}");
      // Get.back(result: "set_direction");
    }
    else {
      print("Error: Failed to fetch place details or invalid response.");
    }
  }

  void removeDriverFromList(String driverID)
  {
    int index = nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == driverID);

    if(nearbyOnlineDriversList.isNotEmpty)
    {
      nearbyOnlineDriversList.removeAt(index);
    }
  }

  void updateOnlineNearbyDriversLocation(OnlineNearbyDrivers nearbyOnlineDriverInformation)
  {
    int index = nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);

    nearbyOnlineDriversList[index].latDriver = nearbyOnlineDriverInformation.latDriver;
    nearbyOnlineDriversList[index].lngDriver = nearbyOnlineDriverInformation.lngDriver;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  // void toggleDriverOnlineStatus() {
  //   isDriverOnline.value = !isDriverOnline.value;
  // }


  Future<void> toggleDriverOnlineStatus() async {
    if (positionOfUser.value != null) {
      // Set up parameters based on current online status
      Map<String, dynamic> params = {
        "driverId": CacheManager.driverId,
        "userId": CacheManager.id,
        "status": isDriverOnline.value ? "offline" : "online",
        "latitude": positionOfUser.value!.latitude,
        "longitude": positionOfUser.value!.longitude,
        "isOnline": isDriverOnline.value ? "0" : "1",
      };


      print("go online payload: $params");
      // Make the API call to go online/offline
      final response = await homeRepo.goOnlineOfflineRepo(params);

      if (response != null && response.statusCode == 200) { // Checking for 200 status code
        // Toggle the online status since the API call was successful
        isDriverOnline.value = !isDriverOnline.value;

        // Show confirmation based on new status
        Get.snackbar(
            'Success',
            isDriverOnline.value ? 'You are now online' : 'You are now offline'
        );
      } else {
        // Show error message if the API call was unsuccessful
        Get.snackbar('Error', 'Failed to update status');
      }
    } else {
      // Handle location error
      Get.snackbar('Location Error', 'Unable to get your current location');
    }
  }

}
