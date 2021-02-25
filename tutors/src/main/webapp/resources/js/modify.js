var modify = {
	
	common: {
		space: { code:'invalid', desc: '������� �Է��ϼ���' }
		, empty: { code:'invalid', desc:'�Է��ϼ���' }	
		, max: { code:'invalid', desc:'�ִ� 10������ �Է��ϼ���' }
		, min: { code:'invalid', desc:'�ּ� 5���̻� �Է��ϼ���' }
	},
	
	tag_status: function( tag ){
		var data = tag.val();
		tag = tag.attr('name');
		if( tag=='pw' ){
			return this.id_status( data );
		}else if( tag=='pw_ck' ){
			return this.pw_status( data );
		}else if( tag=='nickname' ){
			return this.pw_ck_status( data );
		}else if( tag=='email' ){
			return this.email_status( data );
		}
	},
	
	email: {
		valid: { code:'valid', desc:'��밡���� �̸����Դϴ�'}
		, invalid: { code:'invalid', desc:'��� �Ұ����� �̸����Դϴ�'}
	},
	
	email_status: function(email){
		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if( email=='' ) return this.common.empty;
		else if( reg.test(email) ) return this.email.valid;
		else return this.email.invalid;
	},
	
	pw_ck_status: function( pw_ck ){
		if( pw_ck=='' ) return this.common.empty;
		else if( pw_ck == $('[name=pw]').val() ) return this.pw.equal;
		else return this.pw.notEqual;
	},
	
	pw : {
		valid: { code:'valid', desc:'��밡���� ��й�ȣ' }
		, invalid : { code:'invalid', desc:'��й�ȣ�� ���� ��/�ҹ���, ���ڸ� �Է� ����' }	
		, lack : { code:'invalid', desc:'��й�ȣ�� ���� ��/�ҹ���, ���ڸ� ��� �����ؾ� �մϴ�' }
		, equal: { code:'valid', desc:'��й�ȣ�� ��ġ�մϴ�' }
		, notEqual: { code:'invalid', desc:'��й�ȣ�� ��ġ���� �ʽ��ϴ�'}	
	},
	
	pw_status: function( pw ){
		var reg = /[^a-zA-Z0-9]/g;
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g;
		if( pw=='' ) return this.common.empty;
		else if( pw.match(space) ) return this.common.space;
		else if( reg.test(pw) ) return this.pw.invalid;
		else if( pw.length < 5 ) return this.common.min;
		else if( pw.length > 10 ) return this.common.max;
		else if( !upper.test(pw) || !lower.test(pw) || !digit.test(pw) )  
						return this.pw.lack;
		else                      return this.pw.valid;
	},
	
	id_status: function( id ){
		var reg = /[^a-z0-9]/g;
		if( id=='' ) return this.common.empty;
		else if( id.match(space) ) return this.common.space;
		else if( reg.test(id) ) return this.id.invalid;
		else if( id.length < 5 ) return this.common.min;
		else if( id.length > 10 ) return this.common.max;
		else         return this.id.valid;
	}
}
var space = /\s/g;








