% ���������½������Rosenbrock�����ľֲ���Сֵ
% Meringue
% 2017/4/14
% ---------------------------
% ---------------------------
clc
clear all
close all

global xk dk iter

err = 1e-3; % ����Ҫ��
iter = 0; % ��������
iterMax = 1e5; % ����������
x0 = [0,0]';% ��ʼ��
[~,gk] = Rosenbrock(x0); % ���ʼ�ݶ�


xk(:,1) = x0; 
while norm(gk) > err % δ�ﵽ����Ҫ��
    if iter >= iterMax
        fprintf('�ﵽ������������');
        break
    end
    iter = iter+1;
    [~,gk] = Rosenbrock(xk(:,iter));
    dk = -gk; % ȷ����ǰ��������

    % ȷ���������䣨2ѡ1��
    % [lambdaMin,lambdaMax,~] = Trial(@Rosenbrock,xk(:,iter),dk,1,1,2,1e-3); % ����������
    lambdaMin = 0; lambdaMax = 10;% ����һ���С��ֱ�Ӹ�����������

    % ��ȷֱ������ȷ�����Ų�����2ѡ1��
    % lambdak = P618(@Rosenbrock,xk(:,iter),dk,[lambdaMin,lambdaMax],1e-3); % �ƽ�ָ
    lambdak = fminbnd(@Rosenbrock_t,lambdaMin,lambdaMax); % ����fminbnd����
    xk(:,iter+1) = xk(:,iter)+lambdak*dk; % ������һ��
end

% �����ʾ
fprintf('һ��������%d��',iter);
plot(xk(1,:),xk(2,:))
title('�����½�����Rosenbrock�����ľֲ���Сֵ')
xlabel('x_1'); ylabel('x_2');