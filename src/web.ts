import { WebPlugin } from '@capacitor/core';

import type { GetLocalIPPlugin } from './definitions';

export class GetLocalIPWeb extends WebPlugin implements GetLocalIPPlugin {
  async getLocalIP(): Promise<{ ip: string }> {
    // On web, we can use WebRTC to get the local IP
    return new Promise((resolve, reject) => {
      // Create a dummy peer connection
      const pc = new RTCPeerConnection({
        iceServers: [{ urls: 'stun:stun.l.google.com:19302' }]
      });

      // Create a dummy data channel
      pc.createDataChannel('');

      pc.createOffer().then(offer => {
        pc.setLocalDescription(offer);
      });

      pc.onicecandidate = (event) => {
        if (event.candidate) {
          const candidate = event.candidate.candidate;
          const match = candidate.match(/(\d+\.\d+\.\d+\.\d+)/);
          if (match) {
            const ip = match[1];
            // Filter out public IPs and return only local IPs
            if (ip.startsWith('192.168.') || ip.startsWith('10.') || ip.startsWith('172.')) {
              pc.close();
              resolve({ ip });
              return;
            }
          }
        } else {
          pc.close();
          reject(new Error('Unable to determine local IP address'));
        }
      };

      // Timeout after 5 seconds
      setTimeout(() => {
        pc.close();
        reject(new Error('Timeout: Unable to determine local IP address'));
      }, 5000);
    });
  }
}
