var modify = {
	
	common: {
		space: { code:'invalid', desc: '공백없이 입력하세요' }
		, empty: { code:'invalid', desc:'입력하세요' }	
		, max: { code:'invalid', desc:'최대 13자이하 입력하세요' }
		, min: { code:'invalid', desc:'최소 6자이상 입력하세요' }
		, valid: { code:'valid', desc:'유효합니다' }
	},
	
	pw : {
		valid : {code : "valid", desc : "사용가능한 비밀번호"},
		invalid : {code : "invalid", desc:"영어 대문자, 소문자, 특수문자만 입력 가능"},
		lack : {code : "invalid", desc:"영어 대문자, 소문자, 특수문자가 1개이상 포함되어야 합니다"},
		equal : {code : "valid", desc:"비밀번호가 일치합니다"},
		notEqual : {code:"invalid",desc:"비밀번호가 일치하지 않습니다"}
	},
	
	email : {
		valid : {code : "valid", desc : "사용가능한 이메일입니다"},
		invalid : {code : "invalid", desc : "사용 불가능한 이메일입니다"}
	},
	
	tag_status : function(tag){
		var data = tag.val();
		tag = tag.attr("pw");
		if(tag=="pw_ck"){
			return this.pw_status(data);
		}else if(tag=="email"){
			return this.pw_chk_status(data);
		}else if(tag=="nickname"){
			return this.nickname_status(data);
		}
	},
	
	nickname_status : function(nickname){
		if(nickname==""){
			return this.common.empty;
		}else{
			return this.common.valid;
		}
	},
	
	pw_status : function(pw){
		var reg = /[~!@#$%^&*()]/g;
		var lower = /[a-z]/g, digit = /[0-9]/g, nums = /^.{6,13}/g;
		if( pw=="" ) return this.common.empty;
		else if( pw.match(space) ) return this.common.space;
		else if( reg.test(pw) ) return this.pw.invalid;
		else if( pw.length < 5 ) return this.common.min;
		else if( pw.length > 14 ) return this.common.max;
		else if( !lower.test(pw) || !digit.test(pw) || !nums.test(pw) )  
						return this.pw.lack;
		else                      return this.pw.valid;
	},
	
	pw_chk_status : function(pw_ck){
		if( pw_ck=='' ) return this.common.empty;
		else if( pw_ck == $('[name=pw]').val() ) return this.pw.equal;
		else return this.pw.notEqual;
	},
	
	email_status : function(email){
		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if( email=='' ) return this.common.empty;
		else if( reg.test(email) ) return this.email.valid;
		else return this.email.invalid;
	}
}
var space = /\s/g;