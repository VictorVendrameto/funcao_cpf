DELIMITER $

CREATE FUNCTION validacao_cpf(CPF CHAR(11)) RETURNS VARCHAR(20) DETERMINISTIC
BEGIN

DECLARE digito1 INT;
DECLARE digito2 INT;
DECLARE soma INT;
DECLARE indice INT;
DECLARE doc_auxiliar VARCHAR(11);


SET doc_auxiliar = TRIM(CPF);
IF (doc_auxiliar IN ('00000000000', '11111111111', '22222222222', '33333333333','44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999'))THEN
RETURN "CPF inválido";
END IF;

SET digito1 = substring(doc_auxiliar, 10, 1);
SET digito2 = substring(doc_auxiliar, 11, 1);
SET soma = 0;
SET indice = 1;

WHILE (indice <= 9) DO
SET soma = soma + cast(substring(doc_auxiliar, indice, 1) as unsigned) * (11 - indice);
SET indice = indice + 1;
END WHILE;

SET digito1 = 11 -(soma %11);
IF digito1 = 10 THEN
SET digito1 = 0;
END IF;

SET soma = 0;
SET indice = 1;

WHILE (indice <=10) DO
SET soma = soma + cast(substring(doc_auxiliar, indice, 1) AS UNSIGNED) * (12 - indice);
SET indice = indice + 1;
END WHILE;


SET digito2 = 11 - (soma % 11);
IF digito2 = 10 THEN
SET digito2 = 0;
END IF;

IF (digito1 = substring(doc_auxiliar, 10, 1) AND digito2 = substring(doc_auxiliar, 11)) THEN
RETURN "CPF válido";
ELSE
RETURN "CPF inválido";
END IF;

END;
