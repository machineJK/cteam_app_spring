var join = {
	
	common : {
		space : {code : "invalid", desc : "공백없이 입력하세요"},
		empty : {code : "invalid", desc : ""},
		max : {code : "invalid", desc : "최대 10자이하 입력하세요"},
		min : {code : "invalid", desc : "최소 5자이상 입력하세요"}
		
	},

	id : {
		valid : {code : "valid", desc : "중복확인을 해주세요!"},
		invalid : {code : "invalid", desc : "영문소문자,숫자만 입력하세요"},
		usable : {code : "valid", desc:"사용가능한 아이디입니다"},
		unusable : {code :"invalid", desc : "이미 사용중인 아이디입니다"}
	},
	
	pw : {
		valid : {code : "valid", desc : "사용가능한 비밀번호"},
		invalid : {code : "invalid", desc:"비밀번호는 영문 대/소문자, 숫자만 입력 가능"},
		lack : {code : "invalid", desc:"비밀번호는 영문 대/소문자, 숫자를 모두 포함해야 합니다"},
		equal : {code : "valid", desc:"비밀번호가 일치합니다"},
		notEqual : {code:"invalid",desc:"비밀번호가 일치하지 않습니다"}
	},
	
	email : {
		valid : {code : "valid", desc : "사용가능한 이메일입니다"},
		invalid : {code : "invalid", desc : "사용 불가능한 이메일입니다"}
	},
	
	//태그 종류가 무엇인지 판단(id냐 pw냐 등등)
	tag_status : function(tag){
		var data = tag.val();	//태그가 가지고 있는값(ex)id: ska907, pw: 0000)
		tag = tag.attr("name");	//태그 종류
		if(tag=="id"){
			return this.id_status(data);
		}else if(tag=="pw"){
			return this.pw_status(data);
		}else if(tag=="pw_ck"){
			return this.pw_chk_status(data);
		}else if(tag=="email"){
			return this.email_status(data);
		}
	},
	
	id_status : function(id){
		var reg = /[^a-z0-9]/g;
		if(id==""){
			return this.common.empty;
		}else if(id.match(space)){
			return this.common.space;
		}else if(reg.test(id)){
			return this.id.invalid;
		}else if(id.length < 5){
			return this.common.min;
		}else if(id.length > 10){
			return this.common.max;
		}else{
			return this.id.valid;
		}
	},
	
	pw_status : function(pw){
		var reg = /[^a-zA-Z0-9]/g;
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g;
		if(pw==""){
			return this.common.empty;
		}else if(pw.match(space)){
			return this.common.space;
		}else if(reg.test(pw)){
			return this.pw.invalid;
		}else if(pw.length < 5){
			return this.common.min;
		}else if(pw.length > 10){
			return this.common.max;
		}else if(!upper.test(pw) || !lower.test(pw) || !digit.test(pw)){
			return this.pw.lack;
		}else{
			return this.pw.valid;
		}
	},
	
	pw_chk_status : function(pw_ck){
		if(pw_ck == ""){
			return this.common.empty;
		}else if(pw_ck == $("[name=pw]").val()){
			return this.pw.equal;
		}else{
			return this.pw.notEqual;
		}
		
		
	},
	
	email_status : function(email){
		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(email == ""){
			return this.common.empty;
		}else if(!reg.test(email)){
			return this.email.invalid;
		}else{
			return this.email.valid;
		}
	},
	
	id_usable: function(data){
		if(data){
			return this.id.unusable;
		}else{
			return this.id.usable;
		}
		
	}
	
}

var space = /\s/g;



