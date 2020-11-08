function [k,x,val]=bfgs(fun,gfun,x0,varargin)
%���ܣ�BFGS�㷨�����Լ�����⣺min f(x)
%���룺fun��gfun�ֱ���Ŀ�꺯�������ݶȣ�x0�ǳ�ʼ�㣬varargin�������
%   �ɱ��������,�򵥵���BFGSʱ���Ժ�����,������������ѭ�����øó�
%   ��ʱ��������Ҫ������
%�����k�ǵ���������x,val�ֱ��ǽ������ŵ������ֵ
N=1000; %��������������
epsilon=1.e-5; %�����������

beta=0.55; sigma=0.4;
n=length(x0); Bk=eye(n);
k=0;
while(k<N)
    gk=feval(gfun,x0,varargin{:}); %�����ݶ�
    if(norm(gk)<epsilon), break; end %������ֹ׼��
    dk=-Bk\gk; %�ⷽ����Bk*dk=-gk,������������
    m=0; mk=0;
    while(m<20) %��Armijo�����󲽳�
        newf=feval(fun,x0+beta^m*dk ,varargin{:});
        oldf=feval(fun,x0,varargin{:});
        if(newf<=oldf+sigma*beta^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    %BFGSУ��
    x=x0+beta^mk*dk;
    sk=x-x0;
    yk=feval(gfun,x,varargin{:})-gk;
    if(yk'*sk>0)
        Bk=Bk-(Bk*sk*sk'*Bk)/(sk'*Bk*sk)+(yk*yk')/(yk'*sk);
    end
    k=k+1;
    x0=x;
end
val=feval(fun,x0,varargin{:});