class MentalHealthCenter {
  String division;
  String phone1;
  String phone2;
  String email;
  String website;
  String postalCode;
  String address;

  MentalHealthCenter(this.division, this.phone1, this.phone2, this.email, this.website, this.postalCode, this.address);

  @override
  String toString() {
    return 'Division: ${division ?? "-"}\nPhone 1: $phone1\nPhone 2: $phone2\nEmail: $email\nWebsite: $website\nPostal Code: $postalCode\nAddress: $address\n';
  }
}

List<MentalHealthCenter> centers = [
  MentalHealthCenter('강남구 직영', '02-2226-0344', '02-459-1850', 'kcmhc2020@naver.com', 'https://www.gangnam.go.kr/office/smilegn/main.do', '06373', '강남구 자곡로100 자곡문화센터 2층'),
  MentalHealthCenter('강동구 위탁', '02-471-3223', '02-471-3055', 'gdgmhc@hanmai.net', 'https://www.happygd.co.kr/', '05320', '강동구 구천면로 297-5, 1층'),
  MentalHealthCenter('강북구 직영', '02-985-0222', '02-901-5574', 'kangbukcmhc@citizen.seoul.kr', 'http://ehealth.gangbuk.go.kr/site/kr/maeum', '01197', '강북구 삼양로 19길 154, 3층'),
  MentalHealthCenter('강서구 위탁', '02-2600-5926', '02-2620-0506', 'kscmhc@hanmail.net', 'www.kscmhc.or.kr', '07560', '강서구 공항대로 561, B1'),
  MentalHealthCenter('관악구 직영', '02-879-4911', '02-879-7911', 'gkmind@hanmail.net', 'www.gwanakmaum.or.kr', '08832', '관악구 관악로 145, 3동 4층'),
  MentalHealthCenter('광진구 위탁', '02-450-1895', '02-452-1535', 'ggmhc@hanmail.net', 'www.hopegj.or.kr', '04922', '광진구 긴고랑로 110 중곡종합건강센터 4층'),
  MentalHealthCenter('구로구 직영', '02-861-2284', '02-861-2254', 'gurocmhc@hanmail.net', 'www.grcmhc.or.kr', '08298', '구로구 공원로 21, 나라키움 구로복합관사'),
  MentalHealthCenter('금천구 위탁', '02-3281-9314', '02-861-0030', 'gcmhc1@naver.com', 'https://gcmhc.modoo.at/', '08523', '금천구 시흥대로 123길 11, 5층'),
  MentalHealthCenter('노원구 직영', '02-2116-4591', '02-2116-4710', 'nowonmind@nowon.go.kr', 'nowonmind.or.kr', '01689', '노원구 노해로 455'),
  MentalHealthCenter('도봉구 직영', '02-2091-5231', '02-2091-6166', 'minjeongk@dobong.go.kr', 'www.dobongmind.co.kr', '01395', '도봉구 방학로 3길 117, 1층'),
  MentalHealthCenter('동대문구 위탁', '02-963-1621', '02-963-1624', 'ddmmhc@hanmail.net', 'https://www.ddmind.net', '02470', '동대문구 홍릉로 81, 홍릉문화복지센터 4층'),
  MentalHealthCenter('동작구 직영', '02-820-4072', '02-820-9519', 'flue2732@dongjak.go.kr', 'http://www.동작구정신건강복지센터.kr', '07005', '동작구 사당로 253-3 2층'),
  MentalHealthCenter('마포구 위탁', '02-3272-4937', '02-3272-4940', 'mapomhc@hanmail.net', 'mmhwc.or.kr', '03965', '마포구 성산로 4길 15, 3층'),
  MentalHealthCenter('서대문구 직영', '02-3140-8081', '02-337-2175', 'joyfullamb@sdm.go.kr', 'www.sdm.go.kr>health', '03653', '서대문구 연희로 290'),
  MentalHealthCenter('서초구 직영', '02-2155-8215', '02-2155-8197', 'scmind@seocho.go.kr', 'www.scgmhc.or.kr/', '06793', '서초구 염곡말길 9 느티나무쉼터 3층 마음건강센터'),
  MentalHealthCenter('성동구 위탁', '02-2298-1080', '02-2282-4765', 'sdmhc98@hanmail.net', 'www.midcare.or.kr', '04727', '성동구 행당로 12, 성동구보건분소'),
  MentalHealthCenter('성북구 직영', '02-2241-6314', '02-969-8941', 'white0619@sb.go.kr', 'www.sbcmhc1.or.kr', '02751', '성북구 화랑로 63, 성북구보건소'),
  MentalHealthCenter('송파구 직영', '02-2147-5030', '02-2147-3929', 'maeng1011@songpa.go.kr', 'www.songpa.go.kr/ehealth', '05771', '송파구 양산로 5 송파구보건지소'),
  MentalHealthCenter('양천구 위탁', '02-2061-8881', '02-2061-8880', 'yccmhc09@hanmail.net', 'https://yctouch.or.kr', '08095', '양천구 목동서로 339, 보건소 지하1층'),
  MentalHealthCenter('영등포구 직영', '02-2670-4793', '02-2670-4881', '없음', 'www.ydp.go.kr', '07260', '영등포구 당산로 123, 영등포구 보건소 4층'),
  MentalHealthCenter('용산구 직영', '02-2199-8340', '02-2199-5820', 'hongjy10@yongsan.go.kr', 'http://ysmind.org', '04316', '용산구 백범로 329 용산구 보건분소 2층'),
  MentalHealthCenter('은평구 직영', '02-351-8680', '02-351-5685', 'epmhc@ep.go.kr', 'epmind.or.kr', '03347', '은평구 연서로 34길 11'),
  MentalHealthCenter('종로구 위탁', '02-745-0199', '02-745-3549', 'jncmhc@daum.net', 'www.jongnomind.org/', '03066', '종로구 성균관로 15길 10'),
  MentalHealthCenter('중구 위탁', '02-2236-6606', '02-2236-6609', 'jgcmhc@daum.net', 'http://www.junggumind.or.kr', '04506', '중구 서소문로 6길 16 3층'),
  MentalHealthCenter('중랑구 위탁', '02-3422-5921', '02-3422-3805', 'jcmhc@hanmail.net', 'jcmhc.or.kr', '02254', '중랑구 면목로 238, 중랑구민회관')
];