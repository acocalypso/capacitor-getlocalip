import { registerPlugin } from '@capacitor/core';

import type { GetLocalIPPlugin } from './definitions';

const GetLocalIP = registerPlugin<GetLocalIPPlugin>('GetLocalIP', {
  web: () => import('./web').then((m) => new m.GetLocalIPWeb()),
});

export * from './definitions';
export { GetLocalIP };
