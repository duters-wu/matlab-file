function [k,x,val]=dfp(fun,gfun,x0,epsilon,N)
%���ܣ�DFP�㷨�����Լ�����⣺min f(x)
%���룺fun��gfun�ֱ���Ŀ�꺯�������ݶȣ�x0�ǳ�ʼ�㣬
%   epsilon��������N������������
%�����k�ǵ���������x,val�ֱ��ǽ������ŵ������ֵ
if nargin<5, N=1000; end
if nargin<4, epsilon=1.e-5; end

beta=0.55; sigma=0.4;
n=length(x0); Hk=eye(n); k=0;
while(k<N)
    gk=feval(gfun,x0); %�����ݶ�
    if(norm(gk)<epsilon), break; end %������ֹ׼��
    dk=-Hk*gk; %������������
    m=0; mk=0;
    while(m<20) %��Armijo�����󲽳�
        if(feval(fun,x0+beta^m*dk)<=feval(fun,x0)+sigma*beta^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    %DFPУ��
    x=x0+beta^mk*dk;
    sk=x-x0; yk=feval(gfun,x)-gk;
    if(sk'*yk>0)
        Hk=Hk-(Hk*yk*yk'*Hk)/(yk'*Hk*yk)+(sk*sk')/(sk'*yk);
    end
    k=k+1;
    x0=x;
end
val=feval(fun,x0);