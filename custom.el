(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-item-indent 0)
 '(LaTeX-label-function 'reftex-label)
 '(auto-image-file-mode t)
 '(bidi-paragraph-direction 'left-to-right)
 '(company-meghanada-insert-args t)
 '(fancy-splash-image
   "/home/ocramoi/.emacs.d/modules/ui/doom-dashboard/banners/default.png")
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(markdown-command '+markdown-compile t)
 '(markdown-command-needs-filename nil)
 '(markdown-live-preview-window-function 'markdown-live-preview-window-eww)
 '(markdown-open-command "xdg-open" t)
 '(markdown-split-window-direction 'right)
 '(meghanada-completion-matcher "prefix")
 '(meghanada-debug t)
 '(meghanada-full-text-search-enable t)
 '(meghanada-java-path "/usr/bin/java" t)
 '(org-M-RET-may-split-line nil)
 '(org-agenda-files
   '("/home/ocramoi/org/LEPES.org" "/home/ocramoi/org/Napala.org"
     "/home/ocramoi/org/Pessoal.org" "/home/ocramoi/org/Trabalhos.org"
     "/home/ocramoi/org/marcoantonioribeirodetoledo@gmail.com.org"
     "/home/ocramoi/org/mardt@usp.br.org" "/home/ocramoi/org/Freela.org"))
 '(org-directory "~/org" t)
 '(org-display-remote-inline-images 'download)
 '(org-hide-emphasis-markers t)
 '(org-hide-macro-markers t)
 '(org-highlight-latex-and-related '(native latex script entities))
 '(org-image-actual-width nil)
 '(org-latex-prefer-user-labels t t)
 '(org-num-face '(:inherit org-special-keyword :underline nil :weight bold))
 '(org-startup-with-latex-preview t)
 '(package-selected-packages nil)
 '(projectile-git-submodule-command nil)
 '(safe-local-variable-values
   '((eval setq flycheck-clang-include-path
           (list "/home/ocramoi/Documents/Github/ATTiny/mouse/include"
                 "/home/ocramoi/Documents/Github/ATTiny/mouse/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/cores/dtiny"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/variants/digispark"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/Adafruit_NeoPixel"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/ArduinoWiiClassicController"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkCDC"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkJoystick"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkKeyboard"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkLCD"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkMouse"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkOLED"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkRGB"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkRcSeq"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkSimpleServo"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkSoftRcPulseIn"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkSoftRcPulseOut"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkSoftSerial"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkTinyPinChange"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkTinySoftPwm"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/DigisparkUSB"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/Digispark_Examples"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/EEPROM/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/NewExamples"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/Nunchuk"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/OneWire"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/TinyWireM"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-digistump/libraries/Wire/src"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include-fixed"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/avr/include"))
     (eval setq flycheck-clang-include-path
           (list "/home/ocramoi/Documents/Github/ESP32/include"
                 "/home/ocramoi/Documents/Github/ESP32/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/variants/tinyX5"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/EEPROM"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SPI"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo_ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SoftwareSerial"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Wire/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel_Static"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include-fixed"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/avr/include"
                 "/home/ocramoi/.arduino15/packages/digistump/hardware/avr/1.6.7/cores/tiny"
                 "/home/ocramoi/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries"))
     (eval setq flycheck-clang-include-path
           (list "/home/ocramoi/Documents/Github/ESP32/include"
                 "/home/ocramoi/Documents/Github/ESP32/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/cores/tiny"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/variants/tinyX5"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/EEPROM"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SPI"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo_ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SoftwareSerial"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Wire/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel_Static"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include-fixed"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/avr/include"
                 "/home/ocramoi/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries"))
     (eval setq flycheck-clang-include-path
           (list "/home/ocramoi/Documents/Github/ESP32/include"
                 "/home/ocramoi/Documents/Github/ESP32/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/cores/tiny"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/variants/tinyX5"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/EEPROM"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SPI"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Servo_ATTinyCore/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/SoftwareSerial"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/Wire/src"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel"
                 "/home/ocramoi/.platformio/packages/framework-arduino-avr-attiny/libraries/tinyNeoPixel_Static"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/include-fixed"
                 "/home/ocramoi/.platformio/packages/toolchain-atmelavr/avr/include"
                 "-I/home/ocramoi/.arduino15/packages/digistump/hardware/avr/1.6.7/libraries"))))
 '(split-height-threshold nil)
 '(warning-suppress-types
   '((doom-first-file-hook) (doom-first-file-hook) (doom-first-file-hook)
     (doom-first-file-hook) (doom-first-file-hook) (doom-first-file-hook)
     (org-element-cache) (defvaralias))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(python-cell-highlight-face ((t (:inherit ##)))))
