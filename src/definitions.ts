export interface GetLocalIPPlugin {
  /**
   * Get the local IP address of the device
   */
  getLocalIP(): Promise<{ ip: string }>;
}
