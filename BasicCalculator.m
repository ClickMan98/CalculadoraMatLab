classdef BasicCalculator < handle
    properties
        Value = 0; % Valor actual
        Valuef = 0;
        Operator = ''; % Operador actual
        Screen; % Pantalla de la calculadora
    end
    methods
        function obj = BasicCalculator()
            % Crear la figura y los botones
            fig = figure('Name','Calculadora Básica','NumberTitle','off');
            uicontrol('Style','text','Position',[50 380 500 40],'String','Calculadora 1.0 (Calculo de dos numeros)','FontSize',16);
            uicontrol('Style','text','Position',[50 350 500 40],'String','Instrucciones de uso: (Para evitar errores)','FontSize',8,'HorizontalAlignment','left');
            uicontrol('Style','text','Position',[50 330 500 40],'String','1. Introduzca el primer numero, y despues oprima una sola vez la operacion a desarrollar','FontSize',8,'HorizontalAlignment','left');
            uicontrol('Style','text','Position',[50 310 500 40],'String','2. Digite el segundo numero, y oprima igual, esto mostrara el resultado','FontSize',8,'HorizontalAlignment','left');
            uicontrol('Style','text','Position',[50 290 500 40],'String','3. Para operar con el resultado obtenido, digite el operador y vuelva al paso 2','FontSize',8,'HorizontalAlignment','left');
            uicontrol('Style','text','Position',[50 270 500 40],'String','4. Para borrar todo y volverla a usar, oprima el boton c, y vuelva a empezar','FontSize',8,'HorizontalAlignment','left');
            obj.Screen = uicontrol('Style','text','Position',[50 220 200 40],'FontSize',16);
            for i = 0:9
                uicontrol('Style','pushbutton','String',num2str(i),'Position',[50+mod(i,2)*60, 180-floor(i/2)*40, 50, 30],'Callback',{@obj.button_callback,i});
            end
            operators = {'+','-','*','/'};
            for i = 1:4
                uicontrol('Style','pushbutton','String',operators{i},'Position',[170+(i-1)*60, 180, 50, 30],'Callback',{@obj.operator_callback,operators{i}});
            end
            uicontrol('Style','pushbutton','String','=','Position',[290, 140, 50, 30],'Callback',{@obj.equal_callback});
            uicontrol('Style','pushbutton','String','C','Position',[290, 100, 50, 30],'Callback',{@obj.clear_callback});
        end

        function button_callback(obj,~,~,number)
            obj.Value = obj.Value * 10 + number;
            set(obj.Screen,'String',num2str(obj.Value));
        end

        function operator_callback(obj,~,~,operator)
            obj.Valuef = obj.Value;
            obj.Operator = operator;
            obj.Value = 0;
        end

        function equal_callback(obj,~,~)
            result = eval([num2str(obj.Valuef) obj.Operator get(obj.Screen,'String')]);
            set(obj.Screen,'String',num2str(result));
            obj.Value = result;
        end

        function clear_callback(obj,~,~)
            obj.Value = 0;
            obj.Valuef = 0;
            obj.Operator = '';
            set(obj.Screen,'String','');
        end
    end
end