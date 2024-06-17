const cpath = document.body.getAttribute('data-cpath');

// 엔터를 눌렀었을 때 다음 입력란으로 이동
$(document).ready(function() {

   $('input').keydown(function(event) {
      if (event.keyCode === 13) { // Enter 키 코드
         event.preventDefault(); // 기본 Enter 동작 방지
         let inputs = $('input'); // 모든 input 필드 선택
         let currentIndex = inputs.index(this); // 현재 input 필드의 인덱스
         let nextIndex = currentIndex + 1; // 다음 input 필드의 인덱스

         if (this.name == 'memId') {
            // 현재 입력 필드의 ID가 'userId'인 경우
            $('#btnCheckId').click(); // 중복 확인 버튼에 포커스
         } else if (this.name == 'loginPw') {
            // 현재 입력 필드의 이름이 'loginPw'인 경우
            $('#btnLogin').click(); // 로그인 버튼 클릭
         } else if (nextIndex < inputs.length) {
            inputs.eq(nextIndex).focus(); // 다음 입력 필드에 포커스
         } else {
            // 마지막 입력 필드에서 엔터를 누른 경우
            $('#btnPref').focus(); // 제출 버튼에 포커스
         }
      }
   });
});

// 아이디 중복체크
let idChecked = false;

$(document).ready(function() {
   $('#btnCheckId').click(function() {
      let memId = $('input[name="memId"]').val(); // 아이디 필드에서 값 가져오기

      if (memId == '') {
         alert("아이디를 입력해주세요.");
         return;
      }

      $.ajax({
         type: "post",
         url: `${cpath}/checkId`,
         data: {
            "memId": memId
         },
         success: function(data) {
            // data : checkId에서 넘겨준 결과값
            // 반환된 data 값이 "YES"인 경우
            if (data == "YES") {
               alert("사용 가능한 아이디입니다.");
               idChecked = true; // id체크 true
            } else {
               alert("중복된 아이디입니다.");
               $('input[name="memId"]').focus();
               idChecked = false;
            }
            completeJoin();
         },
         error: function(xhr, status, error) {
            alert("아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
            completeJoin();
         }
      });
   });
});

// 비밀번호 확인
let pwChecked = false;
// 비밀번호를 입력한 후 중복검사 실행
$(".pwcheck").focusout(function() {
   checkPw($(this).val())
})
function checkPw(pw) {
   // 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않음
   if (pw == "") {
      $("#checkId").text("");
      return;
   }
   // 만약 pw1과 pw2가 알치하지 않는다면
   if ($('#pw1').val() != $('#pw2').val()) {
      $("#checkPw").html('비밀번호가 일치하지 않습니다');
      $("#checkPw").css('color', 'red');
      $('#pw2').val(''); // 값을 비움
      $('#pw2').focus(); // 포인터를 pw2 로 맞춘다
      pwChecked = false;
   }
   else {
      $("#checkPw").html('비밀번호가 일치합니다'); // 문구 출력
      $("#checkPw").css('color', 'green');
      pwChecked = true; // pw체크 true
   }
   completeJoin();
}


// 아이디,비번 검사 확인 후 가입완료
function completeJoin() {
   window.history.pushState({}, '', `${cpath}/join`);
   // 입력 필드의 값 확인
   let name = $("input[name='name']").val().trim();
   let gender = $("#genderInput").val().trim();
   let birth = $("input[name='birth']").val().trim();

   // 모든 조건이 충족되었는지 확인
   if (idChecked && pwChecked && name && gender && birth) {
      $("#btnPref").removeAttr("disabled");
      $("#btnPref").off("click").on("click", function(e) {

         e.preventDefault();

         $.ajax({
            url: `${cpath}/joiningProcess`,
            type: "post",
            data: $("form").serialize(),
            success: function(response) {
               // console.log(response);
               $.ajax({
                  url: `${cpath}/joiningSurvey`,
                  type: "post",
                  success: function(result) { // 결과 성공 콜백함수
                     window.history.pushState({}, '', `${cpath}/`);
                     console.log(response);
                     console.log(result);
                     
                     // console.log(response); response 가져
                     // 선언된 변수에 초기 HTML 구조를 설정합니다.
                     
                     // 선호도 조사 꾸미기
                     let htmlContent = `
  
    <form id="toggleForm" onsubmit="handleSubmit(event)">
      <fieldset class="checkbox-group">
      <h4 class="h4survey">선호도 조사</h4>
        <legend class="checkbox-group-legend">Choose your favorites</legend>
        <legend class="three">최대 3개까지 선택해주세요</legend>
`;

					  result.forEach((item, index) => {
						  // item.surType 값을 출력하여 확인
						  // console.log(`Item Type: ${item.surType}`);

						  // item.surType 값을 출력하여 확인
						  // console.log(`Item Type: ${item.surType}`);

						  // surDesc에 따라 다른 이미지 경로 설정
						  let imageSrc = ''; // 기본값을 빈 문자열로 설정

						  if (item.surDesc === 'R&B') {
							  imageSrc = 'assets/images/rnb.png'; // 'R&B'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '랩/힙합') {
							  imageSrc = 'assets/images/rap.png'; // '랩/힙합'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '발라드') {
							  imageSrc = 'assets/images/vallade.png'; // '발라드'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '인디') {
							  imageSrc = 'assets/images/indi.png'; // '인디'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '재즈') {
							  imageSrc = 'assets/images/jazz.png'; // '재즈'에 대한 이미지 경로 설정
						  } else if (item.surDesc === 'POP') {
							  imageSrc = 'assets/images/pop.png'; // 'POP'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '댄스') {
							  imageSrc = 'assets/images/dance.png'; // '댄스'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '록/메탈') {
							  imageSrc = 'assets/images/rock.png'; // '록/메탈'에 대한 이미지 경로 설정
						  } else if (item.surDesc === '기타') {
							  imageSrc = 'assets/images/etc.png'; // '기타'에 대한 이미지 경로 설정
						  } else {
							  imageSrc = 'assets/images/default.png'; // 기본 이미지 경로 설정
						  }

						  // console.log(`Image Source: ${imageSrc}`); // 경로가 제대로 설정되었는지 확인
						  // console.log(`Description: ${item.surDesc}`);
						  // console.log(`Current Item:`, item); // item 객체 자체를 로그로 출력
						  htmlContent += `
<div class="checkbox btn-outline-primary" data-bs-toggle="button" aria-pressed="false">
    <label class="checkbox-wrapper">
        <input type="checkbox" class="checkbox-input">
        <span class="checkbox-tile">
            <button type="button" class="btn btn-outline-primary" data-bs-toggle="button" aria-pressed="false">
                <span class="checkbox-icon">
                    <img src="${imageSrc}" alt="${item.surDesc}" class="genre-icon" />
                </span>
                <span class="checkbox-label">${item.surDesc}</span>
            </button>
        </span>
    </label>
</div>

  `;
  
                     });

                     htmlContent += `
                     
      </fieldset>
    </form>
  </div>
`;


                     //선호도 조사 꾸미기 끝

                     // 폼 마감 태그와 추가 버튼을 문자열에 추가합니다.
                     htmlContent += `
                        <br> 
                           <button type='button' class='btn btn-primary btn-sm' id='btnComplete'><span>submit</span>
    <div class="successbtn">
    <svg xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 29.756 29.756" style="enable-background:new 0 0 29.756 29.756;" xml:space="preserve">
      
	<path d="M29.049,5.009L28.19,4.151c-0.943-0.945-2.488-0.945-3.434,0L10.172,18.737l-5.175-5.173   c-0.943-0.944-2.489-0.944-3.432,0.001l-0.858,0.857c-0.943,0.944-0.943,2.489,0,3.433l7.744,7.752   c0.944,0.943,2.489,0.943,3.433,0L29.049,8.442C29.991,7.498,29.991,5.953,29.049,5.009z"/>
 </svg>
      </div>
      </button>
                        </div>
                     `;

                     // 최종적으로 구성된 HTML 문자열을 #prefSurvey에 설정합니다.
                     $("#prefSurvey").html(htmlContent);
                     
                    // 버튼 클릭 이벤트 설정
let btn = document.getElementById("btnComplete");

btn.addEventListener("click", function() {
    btn.classList.toggle("is_active");
});

// CSS 스타일을 추가하여 애니메이션을 정의합니다.
let style = document.createElement('style');
style.innerHTML = `
    .btn-primary.is_active {
        width: 40px;
        height: 40px;
    }

    .btn-primary.is_active .successbtn {
        opacity: 1;
        visibility: visible;
    }

    .btn-primary.is_active .successbtn svg {
        margin-top: 50%;
        transform: translateY(-50%) rotate(720deg) scale(1);
    }

    .btn-primary.is_active span {
        opacity: 0;
        visibility: hidden;
    }
`;
document.head.appendChild(style);



                  },
                  error: function(xhr, status, error) {
                     if (xhr.status == 401) {
                        // 세션이 없어 인증되지 않았을 경우의 처리
                        alert("로그인이 필요합니다.");
                        window.location.href = `${cpath}/mainPage`; // 로그인 페이지로 리다이렉트
                     } else {
                        // 그 외의 오류 처리
                        alert("오류 발생: " + error);
                     }
                  }
               });




               // 동적으로 생성된 #btnComplete 요소에 이벤트 핸들러를 위임합니다.
               $(document).on("click", "#btnComplete", function() {



                  var activeButtons = $("button.active");

                  // 각 버튼의 텍스트 값을 배열에 저장하면서 공백 문자 제거
                  var buttonTexts = [];
                  activeButtons.each(function() {
                     var text = $(this).text().trim(); // 시작과 끝의 공백 제거
                     text = text.replace(/\s+/g, ' '); // 문자열 내의 모든 공백을 하나의 공백으로 치환
                     buttonTexts.push(text);
                  });

                  // 콘솔에 출력
                  console.log("내가 누른 컨텍스트들")
                  console.log(buttonTexts);

                  $.ajax({
                     url: `${cpath}/joinProcess`,
                     type: 'post',
                     contentType: 'application/json',
                     data: JSON.stringify(response),
                     success: function(gomain) {

                        console.log("세션에 vo저장");
                        console.log(response);
                        




                        $.ajax({
                           url: `${cpath}/preference`,
                           type: 'post',
                           contentType: 'application/json',
                           data: JSON.stringify(buttonTexts),
                           success: function(servey) {
                              // console.log("preference 에이잭스들어옴")
                              // 성공 처리 로직
                           },
                           error: function() {
                              // 에러 처리 로직

                           }
                        });


                        setTimeout(function() {
                           window.location.href = `${cpath}/`;
                         }, 2000); // 1000밀리초(1초) 후에 페이지 이동



                     },
                     error: () => {
                        console.log("회원가입 실패");
                     }
                  });
               });
            },

            error: function(xhr, status, error) {
               alert("에러 발생: " + error);
            }

         });

      });
   }
}











// 실시간으로 입력 필드의 변경사항을 감지하여 버튼 활성화 여부를 결정
$("input[name='name'], input[name='birth'], #genderInput").on("change keyup", completeJoin);



// 생년월일 8글자 확인
document.getElementById('joinForm').addEventListener('submit', function(e) {
   let inputBirth = document.getElementById('inputBirth').value;
   if (inputBirth.length !== 8) {
      e.preventDefault(); // 폼 제출 방지
      alert('생년월일을 반드시 8글자로 입력해 주세요.');
   }
});


// 드롭다운을 클릭 이벤트로만 활성화
$(document).ready(function() {

   // 드롭다운 메뉴 항목을 클릭했을 때 드롭다운 메뉴 숨기기
   $('.dropdown-item').click(function() {
      $(this).closest('#ddwGdMenu').removeClass('show'); // 드롭다운 메뉴를 숨깁니다.
   });

   // 바깥쪽을 클릭하면 드롭다운 메뉴 숨기기
   $(document).on('click', function(e) {
      if (!$(e.target).closest('.dropdown').length) {
         $('.dropdown-menu').removeClass('show');
      }
   });
});

// 드롭다운으로 선택한 성별을 화면에 보여주기
$(document).ready(function() {
   $('.dropdown-item').click(function() {
      let selectedGender = $(this).text();
      $('#genderPlaceholder').text(selectedGender)
         .css({
            'color': '#c4c3ca',
            'font-weight': '500',
            'font-size': '14px',
            'opacity': '1'
         });
   });
});

// 드롭다운에서 선택한 value 넘겨주기
let genderDropdown = document.getElementById('dropdownGender');
let genderInput = document.getElementById('genderInput');
let genderPlaceholder = document.getElementById('genderPlaceholder');
let genderItems = document.querySelectorAll('.dropdown-item[data-value]');

// 각 성별 옵션 항목에 대해 클릭 이벤트 리스너 등록
genderItems.forEach(function(e) {
   e.addEventListener('click', function() {
      // 클릭한 항목의 data-value 속성 값을 selectedValue 변수에 저장
      let selectedValue = e.dataset.value;
      // 성별 입력 필드의 값을 selectedValue로 설정
      genderInput.value = selectedValue;
   });
});
