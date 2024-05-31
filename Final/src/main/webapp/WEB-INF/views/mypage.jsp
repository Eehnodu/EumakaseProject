<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이페이지</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet" href="assets/css/mypage.css">
</head>
<body>

	<!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->

  

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="page-content">





          <!-- ***** Banner Start ***** -->
          <div class="row">
            <div class="col-lg-12">
              <div class="main-profile ">
                <div class="row">
                  <div class="col-lg-6">
                    <!-- 차트 영역 -->

                  </div>

                  <div class="col-lg-6 align-self-center">
                    <ul>
                      <li>나의 선호도 <span>뉴진스</span>
                        <br>
                        <span>에스파</span>
                        <br>
                        <span>아이유</span>
                      </li>
                    </ul>
                    <br>
                    <ul>
                      <li>선호하는 장르 <span>댄스</span></li>
                      <li>좋아하는 가수<span>뉴진스</span></li>
                      <li>자주 듣는 노래 <span>Bubble Gum</span></li>
                    </ul>
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-12">
                    <div class="clips">
                      <div class="row">
                        <div class="col-lg-12">
                          <div class="heading-section">
                            <h4><em>내가 듣고 있는</em> playlist</h4>
                          </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                          <div class="item">
                            <div class="thumb">
                              <img src="assets/images/clip-01.jpg" alt="" style="border-radius: 23px;">
                              <a href="https://www.youtube.com/watch?v=r1b03uKWk_M" target="_blank"><i
                                  class="fa fa-play"></i></a>
                            </div>
                            <div class="down-content">
                              <h4>First Clip</h4>
                            </div>
                            <div class="moreInfoButtons mt-2">
                              <button type="button" class="btn btn-sm btn-primary">수정</button>
                              <button type="button" class="btn btn-sm btn-secondary">삭제</button>
                            </div>
                          </div>
                        </div>

                        <div class="col-lg-3 col-sm-6">
                          <div class="item">
                            <div class="thumb">
                              <img src="assets/images/clip-02.jpg" alt="" style="border-radius: 23px;">
                              <a href="https://www.youtube.com/watch?v=r1b03uKWk_M" target="_blank"><i
                                  class="fa fa-play"></i></a>
                            </div>
                            <div class="down-content">
                              <h4>Second Clip</h4>
                            </div>
                            <div class="moreInfoButtons mt-2">
                              <button type="button" class="btn btn-sm btn-primary">수정</button>
                              <button type="button" class="btn btn-sm btn-secondary">삭제</button>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                          <div class="item">
                            <div class="thumb">
                              <img src="assets/images/clip-03.jpg" alt="" style="border-radius: 23px;">
                              <a href="https://www.youtube.com/watch?v=r1b03uKWk_M" target="_blank"><i
                                  class="fa fa-play"></i></a>
                            </div>
                            <div class="down-content">
                              <h4>Third Clip</h4>
                            </div>
                            <div class="moreInfoButtons mt-2">
                              <button type="button" class="btn btn-sm btn-primary">수정</button>
                              <button type="button" class="btn btn-sm btn-secondary">삭제</button>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-3 col-sm-6">
                          <div class="item">
                            <div class="thumb">
                              <img src="assets/images/clip-04.jpg" alt="" style="border-radius: 23px;">
                              <a href="https://www.youtube.com/watch?v=r1b03uKWk_M" target="_blank"><i
                                  class="fa fa-play"></i></a>
                            </div>
                            <div class="down-content">
                              <h4>Fourth Clip</h4>
                            </div>
                            <div class="moreInfoButtons mt-2">
                              <button type="button" class="btn btn-sm btn-primary">수정</button>
                              <button type="button" class="btn btn-sm btn-secondary">삭제</button>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-12">
                          <div class="main-button">
                            <a href="#">더보기</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- ***** Banner End ***** -->

          <!-- ***** Gaming Library Start ***** -->
          <div class="gaming-library profile-library">
            <div class="col-lg-12">
              <div class="heading-section">
                <h4><em>팬 맺은</em> 아티스트</h4>
              </div>
              <div class="item">
                <ul>
                  <li><img src="assets/images/game-01.jpg" alt="" class="templatemo-item"></li>
                  <li>
                    <h4>뉴진스</h4><span>여성/그룹</span>
                  </li>
                  <li>
                    <h4>발매일</h4><span>24/08/2036</span>
                  </li>
                  <li>
                    <h4>Hours Played</h4><span>앨범명</span>
                  </li>
                  <li>
                    <h4>아이돌</h4><span>장르</span>
                  </li>
                  <li>
                    <div class="main-border-button border-no-active"><a href="#">Donwloaded</a></div>
                  </li>
                </ul>
              </div>
              <div class="item">
                <ul>
                  <li><img src="assets/images/game-02.jpg" alt="" class="templatemo-item"></li>
                  <li>
                    <h4>Fortnite</h4><span>Sandbox</span>
                  </li>
                  <li>
                    <h4>Date Added</h4><span>22/06/2036</span>
                  </li>
                  <li>
                    <h4>Hours Played</h4><span>745 H 22 Mins</span>
                  </li>
                  <li>
                    <h4>Currently</h4><span>Downloaded</span>
                  </li>
                  <li>
                    <div class="main-border-button border-no-active"><a href="#">Donwloaded</a></div>
                  </li>
                </ul>
              </div>
              <div class="item last-item">
                <ul>
                  <li><img src="assets/images/game-03.jpg" alt="" class="templatemo-item"></li>
                  <li>
                    <h4>CS-GO</h4><span>Sandbox</span>
                  </li>
                  <li>
                    <h4>Date Added</h4><span>21/04/2022</span>
                  </li>
                  <li>
                    <h4>Hours Played</h4><span>632 H 46 Mins</span>
                  </li>
                  <li>
                    <h4>Currently</h4><span>Downloaded</span>
                  </li>
                  <li>
                    <div class="main-border-button border-no-active"><a href="#">Donwloaded</a></div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <!-- ***** Gaming Library End ***** -->
        </div>
      </div>
    </div>
  </div>

 


  <!-- Scripts -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

  <script src="assets/js/isotope.min.js"></script>
  <script src="assets/js/owl-carousel.js"></script>
  <script src="assets/js/tabs.js"></script>
  <script src="assets/js/popup.js"></script>
  <script src="assets/js/custom.js"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>