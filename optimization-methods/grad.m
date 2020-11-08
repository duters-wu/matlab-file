function [k,x,val] = grad(fun,gfun,x0,epsilon)
% ���ܣ������½��������Լ���Ż����⣺min f(x)
%���룺fun,gfun�ֱ���Ŀ�꺯�������ݶȣ�x0�ǳ�ʼ�㣬epsilonΪ�������
%�����k�ǵ���������x��val�ֱ��ǽ������ŵ������ֵ


maxk=5000; %����������
beta=0.5; sigma=0.4;
k=0;
while(k<maxk)
    gk=feval(gfun,x0); %�����ݶ�
    dk=-gk; %������������
    if(norm(gk)<epsilon), break; end %������ֹԭ��
    m=0; mk=0;
    while(m<20) %Armijo�����󲽳�
        if(feval(fun,x0+beta^m*dk)<=feval(fun,x0)+sigma*beta^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    x0=x0+beta^mk*dk;
    k=k+1;
end
x=x0;
val=feval(fun,x0);
    